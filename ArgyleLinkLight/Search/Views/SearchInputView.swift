import SwiftUI

struct SearchInputView: View {
    @StateObject var viewModel: SearchViewModel

    var body: some View {
        ZStack {
            TextField(Strings.search, text: self.$viewModel.searchText)
                .padding(.vertical, Constants.Spacing.small)
                .padding(.horizontal, Constants.Spacing.regular)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            HStack {
                Spacer()
                Button(action: {
                    self.viewModel.searchText = ""
                    self.viewModel.searchResults = []
                }) {
                    Image(systemName: "xmark.circle")
                        .foregroundColor(.gray)
                }
                .padding(.trailing, Constants.Spacing.regular)
            }
        }
    }
}

struct SearchInputView_Previews: PreviewProvider {
    static var previews: some View {
        SearchInputView(viewModel: SearchViewModel(limit: Constants.limit, networkManager: SearchManager(networkAPI: NetworkAPI.shared)))
    }
}
