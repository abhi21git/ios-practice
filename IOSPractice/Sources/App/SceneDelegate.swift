//
//  SceneDelegate.swift
//  PracticeProject
//
//  Created by Abhishek Maurya on 4/14/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let newWindow = UIWindow(windowScene: windowScene)
        let viewController = HomeTabBarController()
        newWindow.rootViewController = viewController
        window = newWindow
        newWindow.makeKeyAndVisible()
    }

}
