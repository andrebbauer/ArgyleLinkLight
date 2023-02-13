@testable import ArgyleLinkLight
import Foundation

extension LinkItemResponse {
    static var sampleResponse: LinkItemResponse {
        .init(results: [.sampleItem])
    }
}

extension LinkItem {
    static var sampleItem: LinkItem {
        .init(itemID: "id", name: "name", kind: "kind", logoURL: "url")
    }
}

extension Data {
    static var validData: Data {
        try! JSONEncoder().encode(LinkItemResponse.sampleResponse)
    }
}
