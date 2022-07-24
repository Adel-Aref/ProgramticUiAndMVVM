//
//  ViewController+DismisTouching.swift
//  Silicon21
//
//  Created by Adel Aref on 11/04/2021.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    func showDefaultAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//        _ = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(dismissAction)
        present(alert, animated: true, completion: nil)
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    func configureNavigationController() {
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.backIndicatorImage = R.image.brand71()
//        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = R.image.leftArrow2()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    //alert with cancel
    func showAlertWithAction(title: String, message: String, actions:
                [UIAlertAction], style: UIAlertController.Style = .alert, sender: UIView? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let colorNormal: UIColor = #colorLiteral(red: 0.8963955641, green: 0, blue: 0.07718674093, alpha: 1)
        let titleFontAll: UIFont = UIFont(name: "PorscheNextTT-Regular", size: 17.0)!
        alert.setValue(NSAttributedString(string: title, attributes: [.font:
                                                            titleFontAll, .foregroundColor: colorNormal]), forKey: "attributedTitle")
        alert.setValue(NSAttributedString(string: message, attributes: [.font:
                                                            titleFontAll, .foregroundColor : colorNormal]), forKey: "attributedMessage")
        for action in actions {
            alert.addAction(action)
        }
        if let sender = sender {
            if let presenter = alert.popoverPresentationController {
                presenter.sourceView = self.view
                presenter.sourceRect = sender.frame
            }
        }
        present(alert, animated: true, completion: nil)
    }
    func animateUIView(view: UIView) {
        view.alpha = 0
        let transform = CGAffineTransform.init(scaleX: 0.1, y: 0.5)
        view.transform = transform
        UIView.animate(withDuration: 1, delay: 0,
                       usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5,
                       options: .curveEaseIn, animations: {
                        view.alpha = 1
                        view.layer.transform = CATransform3DIdentity
                       }, completion: nil)
    }
}
