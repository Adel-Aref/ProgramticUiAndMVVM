//
//  MovieDetailsViewController.swift
//  AspireTask
//
//  Created by Adel Aref on 09/09/2021.
//

import UIKit
import Kingfisher

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRealseDateLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var movieTotalRateLabel: UILabel!
    @IBOutlet weak var movieAverageRateLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!


    var movie: MovieModel?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setUI()
    }
    func setUI() {
        movieTitleLabel.text = movie?.title ?? ""
        movieOverviewLabel.text = movie?.overview ?? ""
        movieRealseDateLabel.text = movie?.release_date ?? ""
        movieTotalRateLabel.text = String(movie?.vote_count ?? 0)
        movieAverageRateLabel.text = String(movie?.vote_average ?? 0.0)
        let path = ("https://image.tmdb.org/t/p/w300" + (movie?.poster_path ?? ""))
        guard let url = URL(string: path) else {
            self.movieImageView.image = UIImage(named: "")
            return
        }
        self.movieImageView.kf.setImage(with: url)
    }
    @IBAction func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
