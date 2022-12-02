//
//  AppDelegate.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/08.
//

import UIKit

import FirebaseCore
import NMapsMap

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        NMFAuthManager.shared().govClientId = APIKey.clientID
        NMFAuthManager.shared().clientId = APIKey.clientID
        
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        
//        UINavigationBar.appearance().backIndicatorImage = Asset.NavigationBar.arrow.image
//        UINavigationBar.appearance().backIndicatorTransitionMaskImage = Asset.NavigationBar.arrow.image
//        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.clear]
        UINavigationBar.appearance().tintColor = Asset.Colors.BlackWhite.black.color
//        UINavigationBar.appearance().shadowImage = UIImage()
        
        let appearance = AppAppearance.navigationBarAppearance
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

