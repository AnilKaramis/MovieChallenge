//
//  UIImageView+Extensions.swift
//  Teknasyon MVVM Template
//
//  Created by YusufDemirkoparan on 11.07.2024.
//

import SDWebImage
import UIKit

public extension UIImageView {
    func loadImage(from url: String?, placeholder: UIImage? = nil, options: SDWebImageOptions = [], completed: SDExternalCompletionBlock? = nil) {
        guard let urlString = url, let imageUrl = URL(string: urlString) else {
            image = placeholder
            return
        }

        weak var weakSelf = self
        sd_setImage(with: imageUrl, placeholderImage: placeholder, options: options) { [weak weakSelf] image, error, cacheType, url in
            guard let strongSelf = weakSelf else { return }

            if let currentUrl = url, currentUrl == imageUrl {
                strongSelf.image = image
            } else {
                strongSelf.image = placeholder
            }

            completed?(image, error, cacheType, url)
        }
    }
}
