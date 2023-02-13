import SwiftUI

struct SearchInputView: View {
    @StateObject var viewModel: SearchViewModel
    @State var showFeedback: Bool = false

    var body: some View {
        VStack {
            ZStack {
                TextField(Strings.search, text: self.$viewModel.searchText)
                    .padding(.vertical, Constants.Spacing.small)
                    .padding(.horizontal, Constants.Spacing.regular)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .onChange(of: viewModel.searchText) { text in
                        showFeedback = text.count <= Constants.searchTermMinLength - 1 && text.count != 0
                    }
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
            Text("Search term should contain at least 2 characters")
                .font(.system(.footnote))
                .foregroundColor(.red)
                .opacity(showFeedback ? 1 : 0)
        }
    }
}

struct SearchInputView_Previews: PreviewProvider {
    static var previews: some View {
        SearchInputView(viewModel: SearchViewModel(limit: Constants.limit, networkManager: SearchManager(networkAPI: NetworkAPI.shared)))
    }
}
