import SwiftUI

class MainCoordinator: Coordinator {

    var currentViewController: UIViewController?
    var navigationController: UINavigationController?
    var window: UIWindow

    internal init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let searchView = SearchView()
        let viewController = UIHostingController(rootView: searchView)
        navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
