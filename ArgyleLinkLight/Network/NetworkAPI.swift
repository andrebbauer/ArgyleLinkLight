import Foundation

enum APIError: Error {
    case invalidResponse
    case invalidURL
}

protocol NetworkAPIProtocol {
    func request<T: Decodable>(for endpoint: Endpoint) async throws -> T
}

class NetworkAPI: NetworkAPIProtocol {

    private let session: URLSession = .shared
    private var basicAuth: String {
        let username = APIKeys.keys.apiKeyId
        let password = APIKeys.keys.apiKeySecret
        guard let loginData = "\(username):\(password)".data(using: .utf8) else { return "" }
        return loginData.base64EncodedString()
    }

    func request<T: Decodable>(for endpoint: Endpoint) async throws -> T {
        guard
            let url = endpoint.url
        else {
            throw APIError.invalidURL
        }

        let request = buildRequest(url: url, httpMethod: endpoint.method)

        let (data, response) = try await self.session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }

        return try JSONDecoder().decode(T.self, from: data)
    }

    private func buildRequest(url: URL, httpMethod: String = "GET") -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Basic \(self.basicAuth)", forHTTPHeaderField: "Authorization")
        return request
    }
}

extension NetworkAPI {
    static let shared = NetworkAPI()
}
