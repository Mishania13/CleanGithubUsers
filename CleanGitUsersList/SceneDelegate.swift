//
//  SceneDelegate.swift
//  CleanGitUsersList
//
//  Created by Михаил Звягинцев on 21.10.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let winScene = (scene as? UIWindowScene) else { return }
        let navigationController = UINavigationController()
        navigationController.viewControllers = [UsersListViewController()]
        window = UIWindow(windowScene: winScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

