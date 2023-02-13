@testable import ArgyleLinkLight
import XCTest

final class NetworkAPITests: XCTestCase {

    var session: URLSessionProtocol!
    var networkAPI: NetworkAPIProtocol!
    var endpoint: SearchEndpoint = .search(searchTerm: "", limit: "15")

    func testNetworkApiReturnsCorrectData() async throws {
        session = MockURLSession(mockData: .validData, mockResponse: .validResponse)
        networkAPI = NetworkAPI(session: session)

        let response: LinkItemResponse = try await networkAPI.request(for: endpoint)

        XCTAssertEqual(response, LinkItemResponse.sampleResponse)
    }

    func testNetworkApiReturnsError() async throws {
        session = MockURLSession(mockError: APIError.invalidURL)
        networkAPI = NetworkAPI(session: session)
        do {
            let _: LinkItemResponse = try await networkAPI.request(for: endpoint)
            XCTFail("Expected an error to be thrown")
        } catch let error as APIError {
            XCTAssertEqual(error, .invalidURL)
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }

    func testNetworkApiBadResponse() async throws {
        session = MockURLSession(mockData: .validData, mockResponse: .code404Response)
        networkAPI = NetworkAPI(session: session)
        do {
            let _: LinkItemResponse = try await networkAPI.request(for: endpoint)
            XCTFail("Expected an error to be thrown")
        } catch let error as APIError {
            XCTAssertEqual(error, .invalidResponse)
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }

    func testNetworkApiNoResponseWithData() async throws {
        session = MockURLSession(mockData: .validData)
        networkAPI = NetworkAPI(session: session)
        do {
            let _: LinkItemResponse = try await networkAPI.request(for: endpoint)
            XCTFail("Expected an error to be thrown")
        } catch let error as MockURLSessionError {
            XCTAssertEqual(error, .invalidData)
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }

    func testNetworkApiNoDataWithResponse() async throws {
        session = MockURLSession(mockResponse: .validResponse)
        networkAPI = NetworkAPI(session: session)
        do {
            let _: LinkItemResponse = try await networkAPI.request(for: endpoint)
            XCTFail("Expected an error to be thrown")
        } catch let error as MockURLSessionError {
            XCTAssertEqual(error, .invalidData)
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }
}
