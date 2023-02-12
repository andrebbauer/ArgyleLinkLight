import SwiftUI

class SearchViewModel: ObservableObject {

    @Published var searchText: String = ""
    @Published var searchResults: [LinkItem] = [sampleLinkItem]

    private let limit: String
    private let networkManager: SearchManagerProtocol

    init(
        limit: Int,
        networkManager: SearchManagerProtocol
    ) {
        self.limit = String(limit)
        self.networkManager = networkManager
    }

    let debounceTime: Double = 0.5
    let resultLimit: Int = 15

    func search() {
        Task {
            let result = await networkManager.search(for: searchText, limit: limit)
            switch result {
            case .success(let items):
                await MainActor.run {
                    searchResults = items
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}
