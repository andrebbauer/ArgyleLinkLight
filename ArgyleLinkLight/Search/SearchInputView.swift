//
//  SearchInputView.swift
//  ArgyleLinkLight
//
//  Created by André on 11/02/23.
//

import SwiftUI

struct SearchInputView: View {

    @StateObject var viewModel: SearchViewModel
    @State var isSearching: Bool = false

    var body: some View {
        ZStack {
            TextField(Strings.search, text: $viewModel.searchText)
                .padding(.vertical, Style.Spacing.small)
                .padding(.horizontal, Style.Spacing.padding)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .onChange(of: viewModel.searchText, perform: { string in
                    isSearching = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + viewModel.debounceTime) {
                        if isSearching && string.count >= 2 {
                            viewModel.search()
                        }
                    }
                })
            HStack {
                Spacer()
                Button(action: {
                    viewModel.searchText = ""
                    viewModel.searchResults = []
                }) {
                    Image(systemName: "xmark.circle")
                        .foregroundColor(.gray)
                }
                .padding(.trailing, Style.Spacing.padding)
            }
        }
    }
}

struct SearchInputView_Previews: PreviewProvider {
    static var previews: some View {
        SearchInputView(viewModel: SearchViewModel())
    }
}
