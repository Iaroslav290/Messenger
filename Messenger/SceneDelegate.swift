//
//  SceneDelegate.swift
//  Messenger
//
//  Created by Ярослав Вербило on 2023-06-20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var userDefault = UserDefaults.standard


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        
//        userDefault.setValue(false, forKey: "isLogin")
        let isLogin = userDefault.object(forKey: "isLogin") as? Bool ?? false
        
        if isLogin {
            startApp()
        }else {
            startLogin()
        }

    }
    
    func startApp() {
        let controller = AppViewController()
//        let navigationController = UINavigationController(rootViewController: controller)
//        let navController = MessagesViewController()
//        let navigationController = UINavigationController()
//        navigationController.viewControllers.append(navController)
        
        self.window?.rootViewController = controller
        self.window?.makeKeyAndVisible()
    }
    
    func startLogin() {
        let controller = LoginViewController()
        //let navigationController = UINavigationController(rootViewController: controller)
//        let navigationController = UINavigationController()
//        navigationController.viewControllers.append(controller)
        
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

