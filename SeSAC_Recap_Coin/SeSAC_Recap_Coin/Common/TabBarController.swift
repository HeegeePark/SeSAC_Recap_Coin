//
//  TabBarController.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 2/27/24.
//

import UIKit

final class TabBarController: UITabBarController {
    
    private lazy var tabs: [UIViewController] = [
        UINavigationController(rootViewController: TrendingViewController()),
        UINavigationController(rootViewController: SearchViewController()),
        UINavigationController(rootViewController: FavoriteViewController())
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarAppearance()
        setTabBarItems()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let imageView = tabBar.subviews[item.tag + 1].subviews.compactMap({ $0 as? UIImageView }).first
        else { return }
        tabBarItemBounceAnimation(imageView: imageView)
    }
}

// MARK: - Functions

extension TabBarController {
    private func setTabBarAppearance() {
        UITabBar.appearance().backgroundImage = nil
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().tintColor = .accentColor
        UITabBar.appearance().unselectedItemTintColor = .lightGray
    }
    
    private func setTabBarItems() {
        zip(tabs, TabBarItem.allCases).forEach { (tab, item) in
            tab.tabBarItem = item.asTabBarItem()
            tab.tabBarItem.tag = item.rawValue
            tab.tabBarItem.imageInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        setViewControllers(tabs, animated: true)
    }
    
    private func tabBarItemBounceAnimation(imageView: UIImageView) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseInOut) {
            
            imageView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0.5,
                           options: .curveEaseInOut) {
                
                imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
}
