//
//  TabBarController.swift
//  AspireTask
//
//  Created by Adel Aref on 08/09/2021.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {

    fileprivate lazy var defaultTabBarHeight = { tabBar.frame.size.height }()

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupApperence()
    }
    //    // MARK: - Setups
    private func setupApperence() {
        tabBar.barTintColor = UIColor.white
        UITabBar.appearance().tintColor =  R.color.mainColor()
        UITabBar.appearance().unselectedItemTintColor = R.color.secondaryColor()
        UITabBarItem.appearance()
            .setTitleTextAttributes([NSAttributedString.Key.font:
                                        UIFont.systemFont(ofSize: 12.0)],
                                    for: .normal)
    }
    private func setupSubviews() {
        createTabbarControllers()
    }
    // MARK: - Helpers
    private func createTabbarControllers() {
        let systemTags: [TabBarItem] = [.home, .topRated, .search, .favorite]
        let viewControllers = systemTags.compactMap { self.createController(for: $0, with: $0.tag) }
        self.viewControllers = viewControllers
    }

    private func createController(for customTabBarItem: TabBarItem, with tag: Int) -> UINavigationController? {
        let viewController = getController(forItem: customTabBarItem)
        viewController.tabBarItem = customTabBarItem.tabBarItem
        let nav = UINavigationController(rootViewController: viewController)
        nav.navigationBar.isHidden = true
        return nav
    }
    func getController(forItem: TabBarItem) -> UIViewController {
        switch forItem {
        case .home:
            guard let viewController = HomeViewController.instantiateFromNib() else { return UIViewController() }
            return viewController
        case .topRated:
            let layout = UICollectionViewFlowLayout()
           return TopRatedViewController(collectionViewLayout:layout )
        case .search:
            guard let viewController = SearchViewController.instantiateFromNib() else { return UIViewController() }
            return viewController
        case .favorite:
            guard let viewController = FavoriteViewController.instantiateFromNib() else { return UIViewController() }
            return viewController
        }
    }

}
