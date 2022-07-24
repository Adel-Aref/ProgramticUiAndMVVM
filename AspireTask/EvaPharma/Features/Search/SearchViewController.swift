//
//  SearchViewController.swift
//  AspireTask
//
//  Created by Adel Aref on 09/09/2021.
//

import UIKit
import RxSwift
import RxCocoa
import ESPullToRefresh

class SearchViewController: UIViewController {
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    var viewModel = MovieViewModel()
    lazy var disposeBag: DisposeBag = {
        return DisposeBag()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBasicBinding()
        pullToRefresh()
        setUpSearchBar()
        setUpOrdersCollectionView()
        viewModel.getMovies()
    }
    private func pullToRefresh() {
        self.moviesCollectionView.es.addPullToRefresh {
            [unowned self] in
            self.viewModel.page = 1
            self.viewModel.getMovies()
            self.moviesCollectionView.es.stopPullToRefresh()
        }
    }
    private func setUpSearchBar() {
        searchBar.showsCancelButton = false
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        definesPresentationContext = true
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
                              cellType: MovieCollectionCell.self)) { _, model, cell in
                cell.itemCell = model
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
                if indexPath.row == (self.viewModel.cachedMovies.count) - 1 {
                    self.viewModel.getMovies()
                }
            })
            .disposed(by: disposeBag)
    }
}
extension SearchViewController: UICollectionViewDelegateFlowLayout {
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
extension SearchViewController: UISearchBarDelegate {
    func searchBarIsEmpty() -> Bool {
        //Returns true if the text is empty or nil
        return searchBar.text?.isEmpty ?? true
    }
    func filterContentForTextSearch(searchText: String){
        self.moviesCollectionView.reloadSections(NSIndexSet(index: 0) as IndexSet)
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
        self.moviesCollectionView.reloadSections(NSIndexSet(index: 0) as IndexSet)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        view.endEditing(true)
        self.searchBar.showsCancelButton = false
        self.moviesCollectionView.reloadSections(NSIndexSet(index: 0) as IndexSet)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        view.endEditing(true)
        self.searchBar.showsCancelButton = false
        self.moviesCollectionView.reloadSections(NSIndexSet(index: 0) as IndexSet)
    }
    func isFiltering() -> Bool{
        return  !searchBarIsEmpty()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(name: searchText)
    }
}
