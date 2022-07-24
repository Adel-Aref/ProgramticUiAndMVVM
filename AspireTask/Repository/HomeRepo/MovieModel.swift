//
//  MovieModel.swift
//  AspireTask
//
//  Created by Adel Aref on 09/09/2021.
//

import Foundation
import RealmSwift

struct MovieModel: Codable {
    let id: Int
    var title: String?
    var poster_path: String?
    var overview: String? = ""
    var vote_average: Double?
    var vote_count: Int? = 0
    var release_date: String? = ""
    var genre_ids: [Int]? = []
}

class MovieRealmModel: Object, Codable {
    @objc dynamic var id: String?
    @objc dynamic var title: String?
    @objc dynamic var poster_path: String?
    var vote_average: RealmOptional                 = RealmOptional<Double>()

    override class func primaryKey() -> String? {
        return "id"
    }
}
