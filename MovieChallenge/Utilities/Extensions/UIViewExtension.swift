//
//  UIViewExtension.swift
//  MovieChallenge
//
//  Created by AnılKaramış on 26.12.2024.
//

import SnapKit
import UIKit

extension UIView {
    func pin(to view: UIView) {
        self.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
    }
}
