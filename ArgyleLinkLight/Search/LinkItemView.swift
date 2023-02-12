import SwiftUI

struct LinkItemView: View {

    let linkItem: LinkItem
    let errorImage = Image(systemName: "exclamationmark.triangle")

    var body: some View {
        HStack(alignment: .center, spacing: Style.Spacing.padding) {
            AsyncImage(url: URL(string: linkItem.logoURL)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                default:
                    errorImage
                }
            }
            .frame(width: 50, height: 50)
            VStack(alignment: .leading, spacing: Style.Spacing.small) {
                Text(linkItem.name)
                    .font(.headline)
                Text(linkItem.kind.capitalized)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
    }
}

struct LinkItemView_Previews: PreviewProvider {
    static var previews: some View {
        LinkItemView(linkItem: sampleLinkItem)
            .previewLayout(.sizeThatFits)
    }
}
