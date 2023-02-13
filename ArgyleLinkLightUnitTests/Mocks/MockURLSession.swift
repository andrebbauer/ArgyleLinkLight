@testable import ArgyleLinkLight
import Foundation

class MockURLSession: URLSessionProtocol {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?

    init(mockData: Data? = nil, mockResponse: URLResponse? = nil, mockError: Error? = nil) {
        self.mockData = mockData
        self.mockResponse = mockResponse
        self.mockError = mockError
    }

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = mockError {
            throw error
        }

        guard
            let data = mockData,
            let response = mockResponse
        else {
            throw MockURLSessionError.invalidData
        }

        return (data, response)
    }
}

enum MockURLSessionError: Error {
    case invalidData
}
