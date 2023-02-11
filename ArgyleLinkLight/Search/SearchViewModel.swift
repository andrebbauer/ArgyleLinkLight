import SwiftUI

class SearchViewModel: ObservableObject {

    @Published var searchText: String = ""
    @Published var searchResults: [LinkItem] = [sampleLinkItem]

    let debounceTime: Double = 0.5
    let resultLimit: Int = 15

    func search() {
        searchResults = [sampleLinkItem, sampleLinkItem]
    }

    func list() {

    }

}
