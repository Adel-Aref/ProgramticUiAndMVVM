//
//  NETWORK+ENDPOINTS.swift
//  AspireTask
//
//  Created by Adel Aref on 08/09/2021.
//

import Foundation

extension Endpoint {
    static func getMovies(page: Int) -> Endpoint {
        let path = "/movie/now_playing?api_key=\(defaults.apiKey ?? "")&page=\(page)"
        return Endpoint(base: Environment.baseURL, path: path)
    }
    static func getTopRated() -> Endpoint {
        let path = "/movie/top_rated?api_key=\(defaults.apiKey ?? "")"
        return Endpoint(base: Environment.baseURL, path: path)
    }
    static func search(name: String) -> Endpoint {
        let path = "/search/movie?api_key=\(defaults.apiKey ?? "")&query=\(name)"
        return Endpoint(base: Environment.baseURL, path: path)
    }
}
