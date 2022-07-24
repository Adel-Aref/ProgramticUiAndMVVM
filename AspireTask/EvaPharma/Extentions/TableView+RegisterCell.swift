//
//  TableView+RegisterCell.swift
//  Silicon21
//
//  Created by Adel Aref on 11/04/2021.
//

import Foundation
import UIKit
extension UITableView {
    func registerNib(identifier: String) {
        let tableNib = UINib(nibName: identifier, bundle: nil)
        self.register(tableNib, forCellReuseIdentifier: identifier )
    }
}
extension UICollectionView {
    func registerNib(identifier: String) {
        let collectionNib = UINib(nibName: identifier, bundle: nil)
        self.register(collectionNib, forCellWithReuseIdentifier: identifier )
    }
}
extension UITableView {
    func setUpBackgroundView(view: UIView?) {
        guard let view = view else {
            self.backgroundView = nil
            self.separatorStyle = .none
            return
        }
        self.backgroundView = view
    }
}

extension UICollectionView {
    func setUpBackgroundView(view: UIView?) {
        guard let view = view else {
            self.backgroundView = nil
            return
        }
        self.backgroundView = view
    }
}
