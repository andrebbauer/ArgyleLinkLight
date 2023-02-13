@testable import ArgyleLinkLight
import SwiftUI
import XCTest

final class MainCoordinatorTests: XCTestCase {
    var window: UIWindow!
    var coordinator: MainCoordinator!
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        coordinator = MainCoordinator(window: window)
    }
    
    override func tearDown() {
        window = nil
        coordinator = nil
        super.tearDown()
    }
    
    func testStart() {
        coordinator.start()
        XCTAssertNotNil(coordinator.window.rootViewController)
        XCTAssertTrue(coordinator.window.rootViewController is UINavigationController)
        XCTAssertNotNil(coordinator.currentViewController)
        XCTAssertTrue(coordinator.currentViewController is UIHostingController<SearchView>)
        XCTAssertNotNil(coordinator.navigationController)
        XCTAssertTrue(coordinator.navigationController!.viewControllers.first! is UIHostingController<SearchView>)
    }
}

