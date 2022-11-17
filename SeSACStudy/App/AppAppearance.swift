//
//  AppAppearance.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/17.
//

import UIKit

final class AppAppearance {
    private init() { }
    
    static var navigationBarAppearance: UINavigationBarAppearance {
        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
//        let a = UINavigationBar.appearance().back
        
        let appearance = UINavigationBarAppearance()
        
        appearance.backgroundColor = Asset.Colors.BlackWhite.white.color
        appearance.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
//        appearance.shadowImage = UIImage()
        appearance.backButtonAppearance = backButtonAppearance
        appearance.setBackIndicatorImage(Asset.NavigationBar.arrow.image,
                                         transitionMaskImage: Asset.NavigationBar.arrow.image)
        
        return appearance
    }
}
