//
//  UIView+RoundCorners.swift
//  AspireTask
//
//  Created by Adel Aref on 08/09/2021.
//

import Foundation
import UIKit
extension UIView {
    func roundViewCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    func roundCorners(radius: CGFloat) {
          self.layer.cornerRadius = CGFloat(radius)
          self.clipsToBounds = true
          self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
      }
}
