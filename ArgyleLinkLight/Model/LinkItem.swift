import Foundation

struct LinkItemResponse: Codable, Equatable {
    let results: [LinkItem]
}

struct LinkItem: Codable, Equatable {
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
