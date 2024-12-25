//
//  MovieListCell.swift
//  MovieChallenge
//
//  Created by AnılKaramış on 26.12.2024.
//

import UIKit

class MovieListCell: UITableViewCell {

    private let movieTitleLabel = UILabel()
    private let movieRateLabel = UILabel()
    private let movieDescriptionLabel = UILabel()
    private let movieImage = UIImageView()
    private let starImage = UIImageView(image: UIImage(named: "Star"))
    private let favButton: UIButton = {
        let fav = UIButton()
        fav.imageView?.contentMode = .scaleAspectFit
        fav.setImage(UIImage(systemName: "bookmark"), for: .normal)
        fav.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
        fav.addTarget(self, action: #selector(favButtonAction), for: .touchUpInside)
        return fav
    }()
    
    private var movie: Movie?
    var bookmarkButtonAction: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        makeAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setMovie(movie: Movie?) {
        guard let movie = movie else { return }

        self.movie = movie
        
        movieTitleLabel.text = movie.title
        movieRateLabel.text = "\(movie.rate)/10"
        movieDescriptionLabel.text = movie.overview
        favButton.isSelected = movie.isFav
    }
    
    private func configure() {
        
        addSubview(movieTitleLabel)
        addSubview(movieRateLabel)
        addSubview(movieImage)
        contentView.addSubview(favButton)
        addSubview(movieDescriptionLabel)
        addSubview(starImage)
        
        movieTitleLabel.lineBreakMode = .byTruncatingTail
        movieTitleLabel.numberOfLines = 4
        movieTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        movieImage.image = UIImage(named: "Movie")
        movieImage.layer.cornerRadius = 15
        movieImage.clipsToBounds = true
        
        movieDescriptionLabel.lineBreakMode = .byTruncatingTail
        movieDescriptionLabel.numberOfLines = 5
        movieDescriptionLabel.textColor = .lightGray
        movieDescriptionLabel.font = UIFont.systemFont(ofSize: 16)
    }
    
    @objc private func favButtonAction() {
        bookmarkButtonAction?()
    }
    
    private func makeAllConstraints() {
        movieImage.snp.makeConstraints {
            $0.top.equalTo(snp.top).offset(8)
            $0.leading.equalTo(8)
            $0.width.equalTo(182)
            $0.bottom.equalTo(snp.bottom).offset(-8)
        }
        
        favButton.snp.makeConstraints {
            $0.top.equalTo(movieImage.snp.top).offset(8)
            $0.trailing.equalTo(movieImage.snp.trailing).offset(-8)
        }
        
        favButton.imageView?.snp.makeConstraints {
            $0.size.equalTo(32)
        }
        
        movieTitleLabel.snp.makeConstraints {
            $0.top.equalTo(snp.top).offset(8)
            $0.leading.equalTo(movieImage.snp.trailing).offset(12)
            $0.trailing.equalTo(-16)
        }
        
        starImage.snp.makeConstraints {
            $0.top.equalTo(movieTitleLabel.snp.bottom).offset(16)
            $0.leading.equalTo(movieImage.snp.trailing).offset(16)
            $0.size.equalTo(18)
        }
        
        movieRateLabel.snp.makeConstraints {
            $0.top.equalTo(movieTitleLabel.snp.bottom).offset(16)
            $0.leading.equalTo(starImage.snp.trailing).offset(4)
            $0.trailing.equalTo(-16)
        }
        
        movieDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(movieRateLabel.snp.bottom).offset(16)
            $0.leading.equalTo(movieImage.snp.trailing).offset(16)
            $0.trailing.equalTo(-16)
        }
    }
}
