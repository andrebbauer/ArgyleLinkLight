@testable import ArgyleLinkLight
import XCTest

final class SearchManagerTests: XCTestCase {
    var sut: SearchManager!
    var mockNetworkAPI: NetworkAPIMock!

    override func setUp() {
        super.setUp()
        mockNetworkAPI = NetworkAPIMock()
        sut = SearchManager(networkAPI: mockNetworkAPI)
    }

    override func tearDown() {
        mockNetworkAPI = nil
        sut = nil
        super.tearDown()
    }

    func testSearchSuccess() async {
        let expectedResults: [LinkItem] = [.sampleItem]
        mockNetworkAPI.expectedData = .validData

        let result = await sut.search(for: "example", limit: "10")

        switch result {
        case .success(let results):
            XCTAssertEqual(results, expectedResults)
        case .failure(let error):
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testSearchFailure() async {
        let expectedError = APIError.invalidURL
        mockNetworkAPI.expectedError = expectedError

        let result = await sut.search(for: "example", limit: "10")

        switch result {
        case .success:
            XCTFail("Expected error: \(expectedError)")
        case .failure(let error):
            XCTAssertEqual(error as? APIError, expectedError)
        }
    }
}

