//
//  HomeTabBarController.swift
//  IOSPracticeUI
//
//  Created by Simran Rout on 14/05/23.
//  Copyright © 2023 practice.com. All rights reserved.
//

import UIKit

public final class HomeTabBarController: UITabBarController {
    
    var controllers: [UIViewController] = [] {
        didSet {
            viewControllers = controllers
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabItem()
    }
    
    private func setUpTabItem() {
        delegate = self
        let homeTabController = HomeViewController()
        let homeTabItem = UITabBarItem(title: "Home",
                                       image: UIImage(systemName: "house.circle"),
                                       selectedImage: UIImage(systemName: "house.circle.fill"))
        homeTabController.tabBarItem = homeTabItem
        let homeNavController = UINavigationController(rootViewController: homeTabController)
        
        let moreTabController = MoreViewController()
        let moreTabItem = UITabBarItem(title: "More",
                                       image: UIImage(systemName: "ellipsis.circle"),
                                       selectedImage: UIImage(systemName: "ellipsis.circle.fill"))
        moreTabController.tabBarItem = moreTabItem
        
        controllers = [homeNavController, moreTabController]
    }
}

//MARK: - Tab controller delegate
extension HomeTabBarController: UITabBarControllerDelegate {
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        ///
    }
}
