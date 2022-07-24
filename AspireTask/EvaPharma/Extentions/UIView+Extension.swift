//
//  UIView+Extension.swift
//  AspireTask
//
//  Created by Adel Aref on 08/09/2021.
//

import Foundation
import UIKit
// swiftlint:disable all
extension UIView {

    func makeConstraints(top: NSLayoutYAxisAnchor?,
                         left: NSLayoutXAxisAnchor?,
                         right: NSLayoutXAxisAnchor?,
                         bottom: NSLayoutYAxisAnchor?,
                         topMargin: CGFloat, leftMargin: CGFloat,
                         rightMargin: CGFloat, bottomMargin: CGFloat,
                         width: CGFloat, height: CGFloat) {

        self.translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: topMargin).isActive = true
        }

        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: leftMargin).isActive = true
        }

        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -rightMargin).isActive = true
        }

        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -bottomMargin).isActive = true
        }

        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }

        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }

    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    class func loadFromNib<T>(withName nibName: String) -> T? {
        let nib  = UINib.init(nibName: nibName, bundle: nil)
        let nibObjects = nib.instantiate(withOwner: nil, options: nil)
        for object in nibObjects {
            if let result = object as? T {
                return result
            }
        }
        return nil
    }

    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners,
                    cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         layer.mask = mask
     }

    func setCircular() {
        self.layoutIfNeeded()
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
    func setUpBackgroundDay(label: UILabel, isSelected: Bool) {
        if isSelected {
            self.backgroundColor = R.color.accentColor()
            self.borderWidth = 0.0
            label.textColor = R.color.accentColor()
        } else {
            self.backgroundColor = R.color.accentColor()
            self.borderWidth = 1.0
            self.borderColor = R.color.accentColor()
            label.textColor = R.color.accentColor()
        }
     }
}
