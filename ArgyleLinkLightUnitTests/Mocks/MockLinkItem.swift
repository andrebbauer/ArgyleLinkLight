@testable import ArgyleLinkLight

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
