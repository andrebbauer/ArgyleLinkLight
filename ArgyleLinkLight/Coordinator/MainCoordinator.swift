import SwiftUI

class MainCoordinator: Coordinator {

    var currentViewController: UIViewController?
    var navigationController: UINavigationController?
    var window: UIWindow

    internal init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let viewController = ViewController()
        navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
