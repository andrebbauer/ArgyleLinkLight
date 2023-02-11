import SwiftUI

struct SearchView: View {

    @StateObject var viewModel: SearchViewModel

    var body: some View {
        VStack {
            SearchInputView(viewModel: viewModel)
                .padding(.horizontal, Style.Spacing.padding)
                .padding(.bottom, Style.Spacing.padding)

            if $viewModel.searchResults.isEmpty {
                Text(Strings.noResults)
                    .padding(.top, Style.Spacing.padding)
                    .foregroundColor(.gray)
            } else {
                List(viewModel.searchResults, id: \.itemID) { linkItem in
                    LinkItemView(linkItem: linkItem)
                        .padding(.vertical, Style.Spacing.small)
                }
            }

            Spacer()
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel())
    }
}
