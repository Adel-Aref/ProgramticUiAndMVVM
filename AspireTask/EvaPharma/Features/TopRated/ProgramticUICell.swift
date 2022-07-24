//
//  ProgramticUICell.swift
//  AspireTask
//
//  Created by Adel Aref on 16/10/2021.
//

import UIKit
//swiftlint:disable all


class ProgramticUICell : BaseCell {
    
    var itemCell: MovieModel? {
        didSet {
            let path = ("https://image.tmdb.org/t/p/w300" + (itemCell?.poster_path ?? ""))
            movieTitleLabel.text = itemCell?.title ?? ""
            movieRateLabel.text = String(itemCell?.vote_average ?? 0.0)
            guard let url = URL(string: path) else {
                self.movieImageView.image = UIImage(named: R.image.movie.name)
                return
            }
            print("urll \(url)")
            self.movieImageView.kf.setImage(with: url)
        }
    }

    override func setupViews() {
        addSubview(mainView)
        mainView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        mainView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        mainView.widthAnchor.constraint(equalTo: widthAnchor,multiplier : 1).isActive = true
        mainView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        mainView.addSubview(movieImageView)
        movieImageView.topAnchor.constraint(equalTo: mainView.topAnchor,constant : 0).isActive = true
        movieImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        movieImageView.widthAnchor.constraint(equalTo: widthAnchor,multiplier : 1).isActive = true
        movieImageView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor,constant : -60).isActive = true

        mainView.addSubview(movieTitleLabel)
        movieTitleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor,constant : 10).isActive = true
        movieTitleLabel.leftAnchor.constraint(equalTo: movieImageView.leftAnchor,constant : 0).isActive = true
        movieTitleLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor,constant : -10).isActive = true

        mainView.addSubview(rateImageView)
        rateImageView.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor,constant : 10).isActive = true
        rateImageView.leftAnchor.constraint(equalTo: movieTitleLabel.leftAnchor,constant : 0).isActive = true

        mainView.addSubview(movieRateLabel)
        movieRateLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor,constant : 12).isActive = true
        movieRateLabel.leftAnchor.constraint(equalTo: movieImageView.leftAnchor,constant : 40).isActive = true
        movieRateLabel.rightAnchor.constraint(equalTo: movieImageView.rightAnchor,constant : 40).isActive = true

        mainView.addSubview(likeButton)
        likeButton.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor,constant : 12).isActive = true
        likeButton.rightAnchor.constraint(equalTo: movieImageView.rightAnchor,constant : 0).isActive = true
    }
    
    let  mainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let  movieImageView: UIImageView = {
        let image = UIImageView(image: R.image.homevariant())
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 8
        return image
    }()
    let  rateImageView: UIImageView = {
        let image = UIImageView(image: R.image.starCheckOutline())
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let  likeButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.heartLike(), for: .normal)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame.size.width = 30
        button.frame.size.height = 30
        return button
    }()

    let movieTitleLabel :UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        var font = UIFont(name: "Helvetica Neue", size: 16)
        label.font = font
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    let movieRateLabel :UILabel = {
        let label = UILabel()
        label.textColor = R.color.secondaryColor()
        var font = UIFont(name: "Helvetica Neue", size: 14)
        label.font = font
        label.translatesAutoresizingMaskIntoConstraints = false
        return label

    }()
    
    
}
