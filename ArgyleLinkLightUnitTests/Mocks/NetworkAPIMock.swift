@testable import ArgyleLinkLight
import Foundation

class NetworkAPIMock: NetworkAPIProtocol {
    var expectedData: Data?
    var expectedError: Error?

    func request<T: Decodable>(for endpoint: Endpoint) async throws -> T {
        if let error = expectedError {
            throw error
        }
        guard let data = expectedData else {
            fatalError("Expected data was not provided")
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}
