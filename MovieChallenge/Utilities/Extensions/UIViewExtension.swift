//
//  UIViewExtension.swift
//  MovieChallenge
//
//  Created by AnılKaramış on 26.12.2024.
//

import SnapKit
import UIKit

extension UIView {
    func pinTable(to view: UIView) {
        self.snp.makeConstraints {
            $0.leading.equalTo(view)
            $0.trailing.equalTo(view)
            $0.top.equalTo(view)
            $0.height.equalTo(view.frame.height * 0.7) // ekranın yarısı kadar yükseklik
        }
    }
    func pinCollection(to view: UIView) {
        self.snp.makeConstraints {
            $0.leading.equalTo(view)
            $0.trailing.equalTo(view)
            $0.bottom.equalTo(view)
            $0.top.equalTo(view).offset(view.frame.height * 0.7)
        }
    }
}
