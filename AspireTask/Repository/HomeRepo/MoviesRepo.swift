//
//  HomeRepo.swift
//  AspireTask
//
//  Created by Adel Aref on 09/09/2021.
//

import Foundation

class MoviesRepo: Repository {
    var networkClient: APIRouter
    var cacher: Cacher

    public init(_ client: APIRouter = NetworkClient()) {
        networkClient = client
        cacher = Cacher(destination: .atFolder("MoviesRepo"))
    }
    func getMovies(page: Int, completion: @escaping RepositoryCompletion) {
        guard let url = Endpoint.getMovies(page: page).url else { return }
        if let request = makeRequest(url: url, headers: nil, parameters: nil, query: nil, type: .get) {
            getData(withRequest: request,
                    name: String(describing: MovieModel.self),
                    decodingType: MagixResponse<[MovieModel]>.self, strategy:
                        .networkOnly, completion: completion)
        }
    }
    func getTopRated(completion: @escaping RepositoryCompletion) {
        guard let url = Endpoint.getTopRated().url else { return }
        if let request = makeRequest(url: url, headers: nil, parameters: nil, query: nil, type: .get) {
            getData(withRequest: request,
                    name: String(describing: MovieModel.self),
                    decodingType: MagixResponse<[MovieModel]>.self, strategy:
                        .networkOnly, completion: completion)
        }
    }
    func search(name: String, completion: @escaping RepositoryCompletion) {
        guard let url = Endpoint.search(name: name).url else { return }
        if let request = makeRequest(url: url, headers: nil, parameters: nil, query: nil, type: .get) {
            getData(withRequest: request,
                    name: String(describing: MovieModel.self),
                    decodingType: MagixResponse<[MovieModel]>.self, strategy:
                        .networkOnly, completion: completion)
        }
    }
}

