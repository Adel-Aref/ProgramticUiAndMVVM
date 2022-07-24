//
//  MovieCollectionCell.swift
//  AspireTask
//
//  Created by Adel Aref on 09/09/2021.
//

import UIKit
import Kingfisher

class MovieCollectionCell: UICollectionViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieVoteAverageLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    var likeClousre: (() -> Void)?
    var movie: MovieRealmModel = MovieRealmModel()
    var itemCell: MovieModel? {
        didSet {
            let path = ("https://image.tmdb.org/t/p/w300" + (itemCell?.poster_path ?? ""))
            movieTitleLabel.text = itemCell?.title ?? ""
            movieVoteAverageLabel.text = String(itemCell?.vote_average ?? 0.0)
            guard let url = URL(string: path) else {
                self.movieImageView.image = UIImage(named: R.image.movie.name)
                return
            }
            print("urll \(url)")
            self.movieImageView.kf.setImage(with: url)
        }
    }
    @IBAction func lileAction() {
        likeClousre?()
    }

}
