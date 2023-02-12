import SwiftUI
import Combine

class SearchViewModel: ObservableObject {

    @Published var searchText: String = ""
    @Published var searchResults: [LinkItem] = []

    private let limit: String
    private let networkManager: SearchManagerProtocol
    private var cancellables: [AnyCancellable] = []

    init(
        limit: Int,
        networkManager: SearchManagerProtocol
    ) {
        self.limit = String(limit)
        self.networkManager = networkManager
        self.subscribeToSearchTextChanges()
    }

    func subscribeToSearchTextChanges() {
        self.$searchText
            .debounce(for: .seconds(Constants.debounceTime), scheduler: RunLoop.main)
            .filter { $0.count >= 2 }
            .sink { [weak self ] text in
                self?.search(text)
            }
            .store(in: &self.cancellables)
    }

    func search(_ param: String) {
        Task {
            let result = await self.networkManager.search(for: param, limit: self.limit)
            switch result {
            case .success(let items):
                await MainActor.run {
                    self.searchResults = items
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}
