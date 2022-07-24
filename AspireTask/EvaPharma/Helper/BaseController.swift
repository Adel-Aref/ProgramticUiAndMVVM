//
//  BaseController.swift
//  AspireTask
//
//  Created by Adel Aref on 08/09/2021.
//

import Foundation
import UIKit

class BaseController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func popViewController(_ sender: Any) {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        } else {
            self.dismiss(animated: true)
        }
    }
}
