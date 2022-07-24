//
//  FAvoriteViewModel.swift
//  AspireTask
//
//  Created by Adel Aref on 09/09/2021.
//

import Foundation
import Foundation
import RxSwift
import RealmSwift
// swiftlint:disable all
class FavoriteViewModel: BaseViewModel {
    var isLoading: PublishSubject<Bool> = PublishSubject()
    let isSuccess: PublishSubject<[MovieModel]> = PublishSubject()
    var isError: PublishSubject<ErrorMessage> = PublishSubject()
    var disposeBag: DisposeBag = DisposeBag()
    let storage: LocalStorageProtocol = LocalStorage()

    public init (_ repo: MoviesRepo = MoviesRepo()) {
        isSuccess.disposed(by: disposeBag)
        configureDisposeBag()
    }

    func initVM() {
        self.isLoading.onNext(true)
        let favoriteList: [MovieRealmModel] = storage.objects()
        isSuccess.onNext(self.mapToMovies(realmMovies: favoriteList))
        self.isLoading.onNext(false)

    }
    private func mapToMovies(realmMovies: [MovieRealmModel]) -> [MovieModel] {
        var list = [MovieModel]()
        realmMovies.forEach { realmMove in
            let movie = MovieModel(id: Int(realmMove.id ?? "") ?? 0, title:
                                    realmMove.title, poster_path: realmMove.poster_path,
                                   vote_average: realmMove.vote_average.value)
            list.append(movie)
        }
        return list
    }
}
