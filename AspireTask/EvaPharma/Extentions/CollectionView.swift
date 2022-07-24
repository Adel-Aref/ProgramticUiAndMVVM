//
//  CollectionView.swift
//  Silicon21
//
//  Created by A on 12/04/2021.
//

import UIKit
import RxSwift

extension UICollectionViewDelegateFlowLayout {
    func setupCollectionViewLayout(collectionView: UICollectionView, width: CGFloat, height: CGFloat) -> CGSize {
        let layOut = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layOut?.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        layOut?.minimumLineSpacing = 10.0
        layOut?.minimumInteritemSpacing = 5
        let width = width
        let height = height
        layOut?.itemSize = CGSize(width: width, height: CGFloat(height))
        return layOut?.itemSize ?? CGSize(width: 0, height: 0)
    }
}

extension UICollectionView {
    func animateCollectionView(disposeBag: DisposeBag, viewController: UIViewController) {
        self.rx.willDisplayCell
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { (cell, _) in
                viewController.animateUIView(view: cell)
            })
            .disposed(by: disposeBag)
    }
}

extension UITableView {
    func animateTableView(disposeBag: DisposeBag, viewController: UIViewController) {
        self.rx.willDisplayCell
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { (cell, _) in
                viewController.animateUIView(view: cell)
            })
            .disposed(by: disposeBag)
    }
}
