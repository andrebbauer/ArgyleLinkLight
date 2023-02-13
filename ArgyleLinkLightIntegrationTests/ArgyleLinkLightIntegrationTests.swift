@testable import ArgyleLinkLight
import XCTest

final class ArgyleLinkLightIntegrationTests: XCTestCase {
    var sut: NetworkAPI!

    override func setUp() {
        super.setUp()
        sut = NetworkAPI()
    }

    func testRequestReturnsExpectedType() async throws {
        let endpoint = SearchEndpoint.search(searchTerm: "Amazon", limit: "1")
        let response: LinkItemResponse = try await sut.request(for: endpoint)
        XCTAssertFalse(response.results.isEmpty)
    }

    func testRequestFailsWithWrongType() async throws {
        let endpoint = SearchEndpoint.search(searchTerm: "Amazon", limit: "1")
        do {
            let _: LinkItem = try await sut.request(for: endpoint)
        } catch let error as APIError {
            XCTAssertEqual(error, .failedToDecode)
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }

}
