//
//  MagixResponse.swift
//  AspireTask
//
//  Created by Adel Aref on 08/09/2021.
//

import Foundation

// swiftlint:disable all
struct MagixResponse<T: Codable>: Codable, Cachable {
    var fileName: String? = String(describing: T.self)
    var page: Int?
    var total_pages: Int?
    var results: T?
}
struct ResponseException: Codable {
    var exceptionMessage: String?
}
struct UserID: Codable {
    var userid: String
}
