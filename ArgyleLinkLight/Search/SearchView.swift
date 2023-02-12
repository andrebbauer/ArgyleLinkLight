import SwiftUI

struct SearchView: View {

    @StateObject var viewModel: SearchViewModel

    var body: some View {
        VStack {
            SearchInputView(viewModel: self.viewModel)
                .padding(.horizontal, Constants.Spacing.regular)
                .padding(.bottom, Constants.Spacing.regular)

            if self.viewModel.searchResults.isEmpty {
                Text(Strings.noResults)
                    .padding(.top, Constants.Spacing.regular)
                    .foregroundColor(.gray)
            } else {
                List(self.viewModel.searchResults, id: \.itemID) { linkItem in
                    LinkItemView(linkItem: linkItem)
                        .padding(.vertical, Constants.Spacing.small)
                }
            }

            Spacer()
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel(limit: 15, networkManager: SearchManager(networkAPI: NetworkAPI.shared)))
    }
}
