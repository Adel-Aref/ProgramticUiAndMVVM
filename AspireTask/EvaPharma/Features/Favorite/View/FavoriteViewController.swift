//
//  FavoriteViewController.swift
//  AspireTask
//
//  Created by Adel Aref on 09/09/2021.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

class FavoriteViewController: UIViewController {
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    var viewModel = FavoriteViewModel()
    lazy var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    let storage: LocalStorageProtocol = LocalStorage()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setUpOrdersCollectionView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.initVM()
    }
    private func setupUI() {
        viewModel.isLoading
            .observe(on: MainScheduler.instance)
            .bind(to: self.rx.isAnimating)
            .disposed(by: disposeBag)

        viewModel
            .isError
            .observe(on: MainScheduler.instance)
            .bind(to: self.rx.isError)
            .disposed(by: disposeBag)
    }
    func setUpOrdersCollectionView() {
        moviesCollectionView.registerNib(identifier: R.nib.movieCollectionCell.name)
        moviesCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel.isSuccess
            .bind(to: moviesCollectionView
                    .rx.items(cellIdentifier: R.nib.movieCollectionCell.name,
                        cellType: MovieCollectionCell.self)) { _, model, cell in
                cell.itemCell = model
                cell.likeButton.setImage(UIImage(named: R.image.heartLike.name), for: .normal)
                cell.likeClousre = { [weak self] in
                    guard let self = self else { return }
                    let movie: MovieRealmModel = MovieRealmModel()
                    movie.title = model.title
                    movie.poster_path = model.poster_path
                    movie.vote_average.value = model.vote_average ?? 0.0
                    movie.id = String(model.id )

                    let movieModel: MovieRealmModel? = self.storage.object { $0.id == movie.id }
                       if let movieModel = movieModel {
                        self.storage.delete(movieModel)
                        cell.likeButton.setImage(UIImage(named: R.image.heartDislike.name), for: .normal)
                       } else {
                        self.storage.write(movie)
                        cell.likeButton.setImage(UIImage(named: R.image.heartLike.name), for: .normal)
                       }
                    self.viewModel.initVM()
                }
            }.disposed(by: disposeBag)
        moviesCollectionView.animateCollectionView(disposeBag: disposeBag, viewController: self)
        Observable
            .zip(
                moviesCollectionView
                    .rx
                    .itemSelected, moviesCollectionView
                        .rx
                        .modelSelected(MovieModel.self)
            )
            .bind { [weak self] _, model in
                guard let self = self else { return }
                if let viewController = MovieDetailsViewController.instantiateFromNib() {
                    viewController.movie = model
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
            }.disposed(by: disposeBag)
    }
}
extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    // swiftlint:disable vertical_parameter_alignment
    func collectionView(_ collectionView: UICollectionView, layout
                            collectionViewLayout: UICollectionViewLayout, sizeForItemAt
                                indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height
        let cellWidth = (width - 10) / 2
        return CGSize(width: cellWidth, height: height / 2)
    }
}
