//
//  TabBarItem.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 2/27/24.
//

import UIKit

enum TabBarItem: Int, CaseIterable {
    case trending
    case search
    case favorite
}

extension TabBarItem {
    private var inactiveIcon: UIImage? {
        switch self {
        case .trending:
            return .tabTrendInactive
        case .search:
            return .tabSearchInactive
        case .favorite:
            return .tabPortfolioInactive
        }
    }
    
    private var activeIcon: UIImage? {
        switch self {
        case .trending:
            return .tabTrend
        case .search:
            return .tabSearch
        case .favorite:
            return .tabPortfolio
        }
    }
}

extension TabBarItem {
    public func asTabBarItem() -> UITabBarItem {
        return UITabBarItem(
            title: nil,
            image: inactiveIcon,
            selectedImage: activeIcon
        )
    }
}
