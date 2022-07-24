//
//  UINavigationController+removeLastView.swift
//  AspireTask
//
//  Created by Adel Aref on 08/09/2021.
//

import Foundation
import UIKit

extension UINavigationController {
    func removeLastViewController() {
        var navigationArray = self.viewControllers // To get all UIViewController stack as Array
        navigationArray.remove(at: navigationArray.count - 2) // To remove previous UIViewController
        viewControllers = navigationArray
    }
    func replaceTopViewController(with viewController: UIViewController, animated: Bool) {
      var vcs = viewControllers
      vcs[vcs.count - 1] = viewController
      setViewControllers(vcs, animated: animated)
    }
}
