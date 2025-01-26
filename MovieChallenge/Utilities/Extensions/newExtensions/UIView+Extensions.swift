//
//  UIView+Extensions.swift
//  Teknasyon MVVM Template
//
//  Created by YusufDemirkoparan on 11.07.2024.
//

import UIKit

public extension UIView {
    func addIntoView() -> UIView {
        let view = UIView()
        view.addSubview(self)

        return view
    }
}
