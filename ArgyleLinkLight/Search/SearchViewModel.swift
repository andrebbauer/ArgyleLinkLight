import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var searchResults: [LinkItem] = []
    @Published var isSearching: Bool = false
    @Published var requestFailed: Bool = false
    private var lastTermSearched: String = ""

    var noResults: Bool {
        !self.isSearching && (self.searchResults.isEmpty || self.searchText == "")
    }

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

    private func subscribeToSearchTextChanges() {
        self.$searchText
            .debounce(for: .seconds(Constants.debounceTime), scheduler: RunLoop.main)
            .filter { [weak self] text in
                if text.count < 2 {
                    self?.resetResults()
                }
                return text.count >= 2 && text != self?.lastTermSearched && self?.isSearching == false
            }
            .sink { [weak self ] text in
                self?.search(text)
            }
            .store(in: &self.cancellables)
    }

    private func resetResults() {
        self.lastTermSearched = ""
        self.searchResults = []
    }

    private func search(_ param: String) {
        isSearching = true
        lastTermSearched = param
        Task {
            let result = await self.networkManager.search(for: param, limit: self.limit)
            await MainActor.run {
                switch result {
                case .success(let items):
                    self.isSearching = false
                    self.searchResults = items
                case .failure:
                    self.requestFailed = true
                    self.isSearching = false
                    self.searchResults = []
                }
            }
        }
    }
}
