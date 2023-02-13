import Foundation
@testable import ArgyleLinkLight

class MockNetworkAPI: NetworkAPIProtocol {
    let session: URLSessionProtocol
    var expectedData: Data?
    var expectedError: Error?

    init(session: URLSession) {
        self.session = session
    }

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
