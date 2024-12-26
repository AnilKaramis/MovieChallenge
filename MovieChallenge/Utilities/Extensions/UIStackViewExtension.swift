//
//  UIStackViewExtension.swift
//  MovieChallenge
//
//  Created by AnılKaramış on 26.12.2024.
//

import UIKit

extension UIStackView {
    func addMultipleSubviews(views: [UIView]) {
        arrangedSubviews.forEach { (view) in
            removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
