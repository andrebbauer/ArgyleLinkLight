import Foundation

protocol Endpoint {
    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var method: String { get }
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.baseURL
        components.path = self.path
        components.queryItems = self.parameters

        return components.url
    }
}
