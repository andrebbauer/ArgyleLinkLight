//
//  SceneDelegate.swift
//  ArgyleLinkLight
//
//  Created by André on 11/02/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var mainCoordinator: Coordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        mainCoordinator = MainCoordinator(window: window)
        mainCoordinator?.start()
        self.window = window
    }

}

