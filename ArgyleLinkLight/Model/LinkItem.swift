import Foundation

let sampleLinkItem = LinkItem(itemID: "id", name: "Amazon", kind: "Employer", logoURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Amazon_icon.svg/2500px-Amazon_icon.svg.png")

struct LinkItem: Codable {
    let itemID: String
    let name: String
    let kind: String
    let logoURL: String

    enum CodingKeys: String, CodingKey {
        case itemID = "item_id"
        case name
        case kind
        case logoURL = "logo_url"
    }
}
