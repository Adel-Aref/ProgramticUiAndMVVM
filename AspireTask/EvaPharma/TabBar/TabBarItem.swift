//
//  TabBarItem.swift
//  AspireTask
//
//  Created by Adel Aref on 08/09/2021.
//

import Foundation
import UIKit

enum TabBarItem {
    case home, topRated, search, favorite
}
extension TabBarItem {
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .topRated:
            return "Top Rated"
        case .search:
            return "Search"
        case .favorite:
            return "Favorite"
        }
    }

    var tag: Int {
        switch self {
        case .home:
            return 1
        case .topRated:
            return 2
        case .search:
            return 3
        case .favorite:
            return 4
        }
    }
    var image: UIImage? {
        switch self {
        case .home:
            return R.image.homevariant()
        case .topRated:
            return R.image.rate()
        case .search:
            return R.image.search()
        case .favorite:
            return R.image.fav()
        }
    }

    var tabBarItem: UITabBarItem {
        let tabItem = UITabBarItem(title: title, image: image, tag: tag)
        // here is the customization for my label 2 lines
        return tabItem
    }
}
