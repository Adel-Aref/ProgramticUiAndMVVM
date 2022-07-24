//
//  TopRatedViewController.swift
//  AspireTask
//
//  Created by Adel Aref on 15/10/2021.
//
//swiftlint:disable all
import Foundation
import UIKit
import RxSwift
import RxCocoa


class TopRatedViewController : UICollectionViewController , UICollectionViewDelegateFlowLayout {
    var Cellid0 = "ProgramticUICell"
    var viewModel = MovieViewModel()
    lazy var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cachedMovies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cellid0, for: indexPath) as? ProgramticUICell {
            let movie  = viewModel.cachedMovies[indexPath.row]
            cell.itemCell = movie
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width
        let height = collectionView.bounds.height
        let cellWidth = (width - 50) / 2
        return CGSize(width: cellWidth, height: height / 2.4)
    }

    override func viewDidLoad() {
        collectionView?.contentInset = UIEdgeInsets(top: 30, left: 20, bottom: 20, right: 20)
        collectionView?.backgroundColor = .white
        collectionView?.register(ProgramticUICell.self, forCellWithReuseIdentifier: Cellid0)
        collectionView?.isScrollEnabled = true
        // setup navBar.....
        navigationController?.navigationBar.barTintColor = .gray
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionFootersPinToVisibleBounds = true
        setupRefreshCallbacks()
        viewModel.getTopRated()
    }
    func setupRefreshCallbacks() {
        viewModel.refreshClousre = { [weak self] in
            guard let self = self else {
                return
            }
            self.collectionView.reloadData()
        }
    }

}
