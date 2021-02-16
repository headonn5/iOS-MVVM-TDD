//
//  SceneDelegate.swift
//  MvvmByTddApp
//
//  Created by Paul, Nishant on 16/02/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    window = UIWindow(windowScene: windowScene)
    
    let navigationController = UINavigationController()
    let diContainer: AppDIContainer = AppDIContainer()
    let flowCoordinator = AppFlowCoordinator(navController: navigationController, diContainer: diContainer)
    flowCoordinator.startAppFlow()
    
    window?.rootViewController = navigationController
    
    window?.makeKeyAndVisible()
    
  }

}
