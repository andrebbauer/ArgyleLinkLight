import SwiftUI

class MainCoordinator: Coordinator {
    var currentViewController: UIViewController?
    var navigationController: UINavigationController?
    var window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let networkManager = SearchManager(networkAPI: NetworkAPI.shared)
        let viewModel = SearchViewModel(limit: Constants.limit, networkManager: networkManager)
        let searchView = SearchView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: searchView)
        self.currentViewController = viewController
        self.navigationController = UINavigationController(rootViewController: viewController)
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
}
