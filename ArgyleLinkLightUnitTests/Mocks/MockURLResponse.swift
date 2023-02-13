@testable import ArgyleLinkLight
import Foundation

extension URLResponse {
    static var validResponse: HTTPURLResponse? {
        .init(url: URL(string: "https://www.google.com")!, statusCode: 200, httpVersion: nil, headerFields: [:])
    }
    static var code404Response: HTTPURLResponse? {
        .init(url: URL(string: "https://www.google.com")!, statusCode: 404, httpVersion: nil, headerFields: [:])
    }
}
