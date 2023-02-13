@testable import ArgyleLinkLight
import XCTest

class SearchManagerMock: SearchManagerProtocol {
    var searchExpectation: XCTestExpectation?
    var searchResult: Result<[LinkItem], Error> = .failure(APIError.invalidResponse)

    func search(for searchTerm: String, limit: String) async -> Result<[LinkItem], Error> {
        searchExpectation?.fulfill()
        return searchResult
    }
}
