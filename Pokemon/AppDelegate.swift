//
//  AppDelegate.swift
//  Pokemon
//
//  Created by Rahul Mayani on 13/07/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Variable -
    var window: UIWindow?

    // MARK: - App Life Cycle -
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let nav = NavigationVC(rootViewController: PokemonListVC())
        self.window?.rootViewController = nav
        
        window?.makeKeyAndVisible()
        
        return true
    }
}
