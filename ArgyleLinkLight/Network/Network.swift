import Foundation

protocol Engine {
    var session: URLSession { get }

    func request<T: Decodable>(for endpoint: Endpoint) async throws -> T
}

protocol Endpoint {
    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var method: String { get }
}

enum APIError: Error {
    case invalidResponse
    case invalidURL
}

class NetworkEngine: Engine {

    static let shared = NetworkEngine()

    let session: URLSession
    private var basicAuth: String {
        let username = API.apiKeyId
        let password = API.apiKeySecret
        guard let loginData = "\(username):\(password)".data(using: .utf8) else { return "" }
        return loginData.base64EncodedString()
    }

    private init(session: URLSession = .shared) {
        self.session = session
    }

    func request<T: Decodable>(for endpoint: Endpoint) async throws -> T {
        guard
            let url = buildURL(endpoint: endpoint)
        else {
            throw APIError.invalidURL
        }

        let request = buildRequest(url: url, httpMethod: endpoint.method)

        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }

        return try JSONDecoder().decode(T.self, from: data)
    }

    private func buildURL(endpoint: Endpoint) -> URL? {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.parameters

        return components.url
    }

    private func buildRequest(url: URL, httpMethod: String = "GET") -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Basic \(basicAuth)", forHTTPHeaderField: "Authorization")
        return request
    }
}
