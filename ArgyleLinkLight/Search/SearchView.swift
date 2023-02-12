import SwiftUI

struct SearchView: View {

    @StateObject var viewModel: SearchViewModel

    var body: some View {
        VStack {
            SearchInputView(viewModel: self.viewModel)
                .padding(.horizontal, Constants.Spacing.regular)
                .padding(.bottom, Constants.Spacing.regular)

            if self.viewModel.noResults {
                Text(Strings.noResults)
                    .padding(.top, Constants.Spacing.regular)
                    .foregroundColor(.gray)
            } else {
                ZStack {
                    List(self.viewModel.searchResults, id: \.itemID) { linkItem in
                        LinkItemView(linkItem: linkItem)
                            .padding(.vertical, Constants.Spacing.small)
                    }
                    .animation(.easeIn, value: self.viewModel.isSearching)
                    .blur(radius: self.viewModel.isSearching ? 5 : 0)
                    if self.viewModel.isSearching {
                        VStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    }
                }
            }

            Spacer()
        }
        .alert(Text(Strings.failedFetch), isPresented:  self.$viewModel.requestFailed) {
            Button(action: {
                self.viewModel.requestFailed = false
            }, label: {
                Text(Strings.ok)
            })
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel(limit: Constants.limit, networkManager: SearchManager(networkAPI: NetworkAPI.shared)))
    }
}
