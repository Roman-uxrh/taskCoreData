//
//  SceneDelegate.swift
//  taskCoreData
//
//  Created by admin on 29.03.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let viewController = ListUsersView()
//        let viewController = DetailView()
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
//    func sceneDidEnterBackground(_ scene: UIScene) {
//        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
//    }


}

