//
//  AppDelegate.swift
//  ContainerDemo
//
//  Created by Rauf Aliyev on 30.01.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
//        window?.rootViewController = UINavigationController(rootViewController: HomeController())
        return true
    }

 


}

