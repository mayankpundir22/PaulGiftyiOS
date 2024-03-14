//
//  SceneDelegate.swift
//  PaulGifty
//
//  Created by Mayank Pundir on 11/03/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    internal var window: UIWindow?
    
    static var sceneDelegate: SceneDelegate? {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.delegate as? SceneDelegate
    }
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        changeAppearences()
        
        self.window = UIWindow(windowScene: scene)
        updateRootController()
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


//MARK: Additional Functionalities
extension SceneDelegate {
    
    func updateRootController() {
        //CASE: In case to show Launch Screen Animation
        /*if AppInstance.shared.isShowLaunchAnimation {
            AppInstance.shared.isShowLaunchAnimation = false
            let launchAnimationVC = Storyboard.Other.instantiateVC(type: LaunchAnimationViewController.self)!
            self.window?.rootViewController = launchAnimationVC
            self.window?.makeKeyAndVisible()
            return
        }*/
        //MARK: Testing Purpose Only - Bypass the logic ----
        let navController = UINavigationController()
        //let firstVC = Storyboard.Auth.instantiateVC(type: LoginWithOTPViewController.self)!
        let firstVC = Storyboard.Auth.instantiateVC(type: MapExistingCardViewController.self)!
        navController.viewControllers = [firstVC]
        self.window?.rootViewController = navController
         //-------------------------------- Testing Only ----------------------------------------------
        
        
        
        self.window?.makeKeyAndVisible()
    }
    
    // MARK:- Change Appearance
    private func changeAppearences() {
        UINavigationBar.appearance().tintColor = UIColor.black
        UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().shadowImage = UIImage()
        //UINavigationBar.appearance().isTranslucent = true
        UITabBar.appearance().tintColor = .white
        
        //let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: Fonts.poppinsRegular, size: 15) ?? .systemFont(ofSize: 15)]
        //UINavigationBar.appearance().titleTextAttributes = textAttributes
    }
}
