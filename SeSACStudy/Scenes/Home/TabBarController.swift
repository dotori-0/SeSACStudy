//
//  TabBarController.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/27.
//

import UIKit

final class TabBarController: UITabBarController {
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print("navigationController: \(navigationController)")
//        print("tabBarController: \(tabBarController)")
//        print("tabBarController?.navigationController: \(tabBarController?.navigationController)")

//        navigationItem.hidesBackButton = true
//        navigationController!.isNavigationBarHidden = true
//        navigationController?.navigationBar.isHidden = true
//        navigationController?.navigationBar.scrollEdgeAppearance = nil

        let homeVC = HomeViewController()
        let homeNC = UINavigationController(rootViewController: homeVC)
        
        homeNC.tabBarItem = UITabBarItem(title: String.Home.home,
                                         image: Asset.TabBar.Default.home.image,
//                                         selectedImage: Asset.TabBar.Selected.home.image.withRenderingMode(.automatic))
                                         selectedImage: Asset.TabBar.Selected.home.image)
//        homeNC.navigationBar.scrollEdgeAppearance = nil
//        homeNC.tabBarItem.image = Asset.TabBar.Default.home.image
//        homeNC.tabBarItem.selectedImage = Asset.TabBar.Selected.home.image
        
        let shopVC = ShopViewController()
        let shopNC = UINavigationController(rootViewController: shopVC)
        shopNC.tabBarItem = UITabBarItem(title: String.Shop.sesacShop,
                                         image: Asset.TabBar.Default.shop.image,
                                         selectedImage: Asset.TabBar.Selected.shop.image)
        
        let chatsVC = ChatsViewController()
        let chatsNC = UINavigationController(rootViewController: chatsVC)
        chatsNC.tabBarItem = UITabBarItem(title: String.Chats.friends,
                                         image: Asset.TabBar.Default.friends.image,
                                         selectedImage: Asset.TabBar.Selected.friends.image)
        
        let myInfoVC = MyInfoViewController()
//        let myInfoVC = InfoManagementViewController()
        let myInfoNC = UINavigationController(rootViewController: myInfoVC)
        myInfoNC.tabBarItem = UITabBarItem(title: String.MyInfo.myInfo,
                                         image: Asset.TabBar.Default.myInfo.image,
                                         selectedImage: Asset.TabBar.Selected.myInfo.image)
        
        setViewControllers([homeNC, shopNC, chatsNC, myInfoNC], animated: true)
        selectedIndex = 3
        
        view.tintColor = Asset.Colors.BrandColor.green.color
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("navigationController: \(navigationController)")
        print("tabBarController: \(tabBarController)")
        print("tabBarController?.navigationController: \(tabBarController?.navigationController)")

        navigationItem.hidesBackButton = true
        navigationController?.isNavigationBarHidden = true
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.scrollEdgeAppearance = nil
    }
}
