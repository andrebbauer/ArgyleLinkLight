@testable import ArgyleLinkLight
import XCTest

final class NetworkAPITests: XCTestCase {
    var session: URLSessionProtocol!
    var sut: NetworkAPIProtocol!
    var endpoint: SearchEndpoint = .search(searchTerm: "", limit: "15")

    func testNetworkApiReturnsCorrectData() async throws {
        session = URLSessionMock(mockData: .validData, mockResponse: .validResponse)
        sut = NetworkAPI(session: session)

        let response: LinkItemResponse = try await sut.request(for: endpoint)

        XCTAssertEqual(response, LinkItemResponse.sampleResponse)
    }

    func testNetworkApiReturnsError() async throws {
        session = URLSessionMock(mockError: APIError.invalidURL)
        sut = NetworkAPI(session: session)
        do {
            let _: LinkItemResponse = try await sut.request(for: endpoint)
            XCTFail("Expected an error to be thrown")
        } catch let error as APIError {
            XCTAssertEqual(error, .invalidURL)
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }

    func testNetworkApiBadResponse() async throws {
        session = URLSessionMock(mockData: .validData, mockResponse: .code404Response)
        sut = NetworkAPI(session: session)
        do {
            let _: LinkItemResponse = try await sut.request(for: endpoint)
            XCTFail("Expected an error to be thrown")
        } catch let error as APIError {
            XCTAssertEqual(error, .invalidResponse)
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }

    func testNetworkApiNoResponseWithData() async throws {
        session = URLSessionMock(mockData: .validData)
        sut = NetworkAPI(session: session)
        do {
            let _: LinkItemResponse = try await sut.request(for: endpoint)
            XCTFail("Expected an error to be thrown")
        } catch let error as URLSessionMockError {
            XCTAssertEqual(error, .invalidData)
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }

    func testNetworkApiNoDataWithResponse() async throws {
        session = URLSessionMock(mockResponse: .validResponse)
        sut = NetworkAPI(session: session)
        do {
            let _: LinkItemResponse = try await sut.request(for: endpoint)
            XCTFail("Expected an error to be thrown")
        } catch let error as URLSessionMockError {
            XCTAssertEqual(error, .invalidData)
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }
}
