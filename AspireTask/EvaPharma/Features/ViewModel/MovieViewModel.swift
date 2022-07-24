//
//  MovieViewModel.swift
//  AspireTask
//
//  Created by Adel Aref on 09/09/2021.
//

import Foundation
import RxSwift
// swiftlint:disable all
class MovieViewModel: BaseViewModel {
    var isLoading: PublishSubject<Bool> = PublishSubject()
    let isSuccess: PublishSubject<[MovieModel]> = PublishSubject()
    let movie: PublishSubject<MovieModel> = PublishSubject()
    var isError: PublishSubject<ErrorMessage> = PublishSubject()
    var disposeBag: DisposeBag = DisposeBag()
    let repository: MoviesRepo
    let storage: LocalStorageProtocol = LocalStorage()

    var refreshClousre: (() -> Void)?
    var cachedMovies = [MovieModel]() {
        didSet {
            refreshClousre?()
        }
    }
    var isThereMore = true // to use it in pagination
    var isLoad = false
    var page = 1
    public init (_ repo: MoviesRepo = MoviesRepo()) {
        repository = repo
        isSuccess.disposed(by: disposeBag)
        configureDisposeBag()
    }

    func getMovies() {
        guard self.isLoad == false else {
            return
        }
        self.isLoading.onNext(true)
        self.isLoad = true
        repository.getMovies(page: self.page) { [weak self] (result) in
            guard let self = self else {
                return
            }
            self.isLoading.onNext(false)
            self.isLoad = false
            switch result {
            case .success(let data):
                if let data = data as? MagixResponse<[MovieModel]> {
                    if self.page <= data.total_pages ?? 0 {
                        self.page += 1
                    }
                    if let result = data.results {
                        self.cachedMovies.append(contentsOf: result)
                        self.isSuccess.onNext(self.cachedMovies)
                    }
                }
            case .failure(let error):
                let error = ErrorMessage(title: "Error", message: error.localizedDescription, action: nil)
                self.isError.onNext(error)
            }
        }
    }
    func getTopRated() {
        self.isLoading.onNext(true)
        repository.getTopRated { [weak self] (result) in
            guard let self = self else {
                return
            }
            self.isLoading.onNext(false)
            switch result {
            case .success(let data):
                if let data = data as? MagixResponse<[MovieModel]> {
                    if self.page <= data.total_pages ?? 0 {
                        self.page += 1
                    }
                    if let result = data.results {
                        self.cachedMovies.append(contentsOf: result)
                        self.isSuccess.onNext(self.cachedMovies)
                    }
                }
            case .failure(let error):
                let error = ErrorMessage(title: "Error", message: error.localizedDescription, action: nil)
                self.isError.onNext(error)
            }
        }
    }
    func search(name: String) {
        self.isLoading.onNext(true)
        repository.search(name: name) { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading.onNext(false)
            switch result {
            case .success(let data):
                if let data = data as? MagixResponse<[MovieModel]> {
                    if self.page <= data.total_pages ?? 0 {
                        self.page += 1
                    }
                    if let result = data.results {
                        self.cachedMovies.append(contentsOf: result)
                        self.isSuccess.onNext(self.cachedMovies)
                    }
                }
            case .failure(let error):
                let error = ErrorMessage(title: "Error", message: error.localizedDescription, action: nil)
                self.isError.onNext(error)
            }
        }
    }

}
