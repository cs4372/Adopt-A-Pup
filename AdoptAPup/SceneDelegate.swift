//
//  SceneDelegate.swift
//  AdoptAPup
//
//  Created by Catherine Shing on 6/27/23.
//

import UIKit
import SDWebImage

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: HomeViewController())
        self.window = window
        self.window?.makeKeyAndVisible()
        
        SDImageCache.shared.config.maxDiskSize = 100000 * 200
    }
}
