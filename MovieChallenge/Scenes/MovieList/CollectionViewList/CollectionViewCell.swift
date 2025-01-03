//
//  CollectionViewCell.swift
//  MovieChallenge
//
//  Created by AnılKaramış on 2.01.2025.
//

import UIKit
import Kingfisher

final class CollectionViewCell: UICollectionViewCell {
    
    private let movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(movieImage)
    }
    
    private func makeConstraints() {
        movieImage.snp.makeConstraints {
            $0.trailing.leading.top.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func setMovie(movie: Movie?) {
        guard let movie = movie else { return }
        movieImage.kf.setImage(with: URL(string: Constants.APIConstants.baseImageURL + movie.posterImage))
    }
}
