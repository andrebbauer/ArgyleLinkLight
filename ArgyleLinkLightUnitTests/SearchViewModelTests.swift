@testable import ArgyleLinkLight
import XCTest

final class SearchViewModelTests: XCTestCase {
    var searchManagerMock: SearchManagerMock!
    var sut: SearchViewModel!

    override func setUp() {
        super.setUp()
        searchManagerMock = SearchManagerMock()
        sut = SearchViewModel(limit: Constants.limit, networkManager: searchManagerMock)
    }

    func testNoResultsIsSearchingFalse() {
        XCTAssertTrue(sut.noResults)
        sut.searchResults = [.sampleItem]
        sut.searchText = "test"
        XCTAssertFalse(sut.noResults)
    }

    func testNoResultsIsSearchingTrue() {
        sut.isSearching = true
        XCTAssertFalse(sut.noResults)
        sut.searchResults = [.sampleItem]
        sut.searchText = "test"
        XCTAssertFalse(sut.noResults)
    }

    func testSearchTextChangesCallsSearchWithSuccess() {
        let expectation = XCTestExpectation(description: "Search is called")
        let expectation2 = XCTestExpectation(description: "Search is completed")
        let results: [LinkItem] = [.sampleItem]
        searchManagerMock.searchExpectation = expectation
        searchManagerMock.searchResult = .success(results)

        sut.searchText = "test"
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(sut.isSearching)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertFalse(self.sut.isSearching)
            XCTAssertFalse(self.sut.requestFailed)
            XCTAssertFalse(self.sut.searchResults.isEmpty)
            XCTAssertEqual(self.sut.searchResults, results)
            expectation2.fulfill()
        }
        wait(for: [expectation2], timeout: 1)
    }

    func testSearchTextChangesCallsSearchWithFailure() {
        let expectation = XCTestExpectation(description: "Search is called")
        let expectation2 = XCTestExpectation(description: "Search is completed")
        searchManagerMock.searchExpectation = expectation
        searchManagerMock.searchResult = .failure(APIError.invalidResponse)

        sut.searchText = "test"
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(sut.isSearching)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertFalse(self.sut.isSearching)
            XCTAssertTrue(self.sut.requestFailed)
            XCTAssertTrue(self.sut.searchResults.isEmpty)
            expectation2.fulfill()
        }
        wait(for: [expectation2], timeout: 1)
    }
}

