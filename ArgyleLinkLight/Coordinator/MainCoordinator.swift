import SwiftUI

class MainCoordinator: Coordinator {

    var currentViewController: UIViewController?
    var navigationController: UINavigationController?
    var window: UIWindow

    internal init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let networkManager = SearchNetworkManager(engine: NetworkEngine.shared)
        let viewModel = SearchViewModel(limit: 15, networkManager: networkManager)
        let searchView = SearchView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: searchView)
        navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
