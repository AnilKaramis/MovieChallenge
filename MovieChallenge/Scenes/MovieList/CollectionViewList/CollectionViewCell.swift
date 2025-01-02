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
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
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
        addSubview(stackView)
        stackView.addArrangedSubview(movieImage)
    }
    
    private func makeConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setMovie(movie: Movie?) {
        guard let movie = movie else { return }
        movieImage.kf.setImage(with: URL(string: Constants.APIConstants.baseImageURL + movie.posterImage))
    }
}
