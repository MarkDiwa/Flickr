//
//  AppDelegate.swift
//  flickr-image-search
//
//  Created by Mark Dennis Diwa on 1/22/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        navigateToStartViewController()
        return true
    }
    
}

extension AppDelegate {
    
    func navigateToStartViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let startViewController = SearchViewController()
        startViewController.viewModel = SearchViewModel()
        let navigationController = UINavigationController(rootViewController: startViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
