import SwiftUI

struct LinkItemView: View {
    let linkItem: LinkItem
    let errorImage = Image(systemName: "exclamationmark.triangle")

    var body: some View {
        HStack(alignment: .center, spacing: Constants.Spacing.regular) {
            if let logoURL = self.linkItem.logoURL {
                AsyncImage(url: URL(string: logoURL)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                    default:
                        self.errorImage
                            .resizable()
                    }
                }
                .frame(width: 50, height: 50)
            } else {
                self.errorImage
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            VStack(alignment: .leading, spacing: Constants.Spacing.small) {
                Text(self.linkItem.name)
                    .font(.headline)
                Text(self.linkItem.kind.capitalized)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
    }
}

struct LinkItemView_Previews: PreviewProvider {
    static var previews: some View {
        LinkItemView(linkItem: LinkItem(itemID: "id", name: "name", kind: "kind", logoURL: " url"))
            .previewLayout(.sizeThatFits)
    }
}
