@testable import ArgyleLinkLight
import XCTest

final class SearchManagerTests: XCTestCase {
    var searchManager: SearchManager!
    var mockNetworkAPI: MockNetworkAPI!

    override func setUp() {
        super.setUp()
        mockNetworkAPI = MockNetworkAPI()
        searchManager = SearchManager(networkAPI: mockNetworkAPI)
    }

    func testSearchSuccess() async {
        let expectedResults: [LinkItem] = [.sampleItem]
        mockNetworkAPI.expectedData = .validData

        let result = await searchManager.search(for: "example", limit: "10")

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

        let result = await searchManager.search(for: "example", limit: "10")

        switch result {
        case .success:
            XCTFail("Expected error: \(expectedError)")
        case .failure(let error):
            XCTAssertEqual(error as? APIError, expectedError)
        }
    }
}

