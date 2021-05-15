//
//  AppDelegate.swift
//  HealthTips
//
//  Created by Arshad Khan on 4/2/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let service = TipsListNetworking(networkHandler: NetworkHandler(session: URLSession(configuration: .default)))
        let viewModel = TipsListViewModel(tipsListNetworking: service)
        let rootVC = TipsListViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: rootVC)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController
        return true
    }
}

