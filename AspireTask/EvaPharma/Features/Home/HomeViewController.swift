//
//  HpmeViewController.swift
//  AspireTask
//
//  Created by Adel Aref on 09/09/2021.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift
import ESPullToRefresh
import Instructions

class HomeViewController: UIViewController {
    @IBOutlet weak var moviesCollectionView: UICollectionView!

    var viewModel = MovieViewModel()
    let coachMarksController = CoachMarksController()
    var pointOfInterest: UIView!
    lazy var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBasicBinding()
        pullToRefresh()
        setUpOrdersCollectionView()
        viewModel.getMovies()
        self.coachMarksController.dataSource = self
        self.coachMarksController.delegate = self
    }
    private func pullToRefresh() {
        self.moviesCollectionView.es.addPullToRefresh {
            [unowned self] in
            self.viewModel.page = 1
            self.viewModel.getMovies()
            // Set ignore footer or not
            self.moviesCollectionView.es.stopPullToRefresh()
        }
    }
    private func setupBasicBinding() {
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
                              cellType: MovieCollectionCell.self)) { row, model, cell in
                if !(defaults.isShowInstruction) {
                    self.pointOfInterest = cell.likeButton
                    self.coachMarksController.start(in: .window(over: self))
                    defaults.isShowInstruction = true
                }
                cell.itemCell = model
                cell.likeClousre = { [weak self] in
                    guard let self = self else { return }
                    let movie: MovieRealmModel = MovieRealmModel()
                    movie.title = model.title
                    movie.poster_path = model.poster_path
                    movie.vote_average.value = model.vote_average ?? 0.0
                    movie.id = String(model.id )

                    let movieModel: MovieRealmModel? = self.viewModel.storage.object { $0.id == movie.id }
                    if let movieModel = movieModel {
                        self.viewModel.storage.delete(movieModel)
                        cell.likeButton.setImage(UIImage(named: R.image.heartDislike.name), for: .normal)
                    } else {
                        self.viewModel.storage.write(movie)
                        cell.likeButton.setImage(UIImage(named: R.image.heartLike.name), for: .normal)
                    }
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
        moviesCollectionView.rx
            .willDisplayCell
            .subscribe(onNext: { cell, indexPath in
                //Do your will display logic
                //                    if inde
            })
            .disposed(by: disposeBag)
        moviesCollectionView.rx
            .willDisplayCell
            .subscribe(onNext: { cell, indexPath in
                if indexPath.row == (self.viewModel.cachedMovies.count) - 1 {
                    self.viewModel.getMovies()
                }
            })
            .disposed(by: disposeBag)
    }
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
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
extension HomeViewController: CoachMarksControllerDataSource,
                                  CoachMarksControllerDelegate {
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return 1
    }
    func coachMarksController(_ coachMarksController: CoachMarksController,
                              coachMarkAt index: Int) -> CoachMark {
        return coachMarksController.helper.makeCoachMark(for: pointOfInterest)
    }
    func coachMarksController(
        _ coachMarksController: CoachMarksController,
        coachMarkViewsAt index: Int,
        madeFrom coachMark: CoachMark
    ) -> (bodyView: UIView & CoachMarkBodyView, arrowView: (UIView & CoachMarkArrowView)?) {
        let coachViews = coachMarksController.helper.makeDefaultCoachViews(
            withArrow: true,
            arrowOrientation: coachMark.arrowOrientation
        )
        coachViews.bodyView.hintLabel.text = "You can press like movie and see it in your favorite list"
        coachViews.bodyView.nextLabel.text = "OK"
        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
    }
    func coachMarksController(_ coachMarksController: CoachMarksController, didHide coachMark: CoachMark, at index: Int) {
    }
}
