//
//  UIT.swift
//  Teknasyon MVVM Template
//
//  Created by YusufDemirkoparan on 11.07.2024.
//

import UIKit

public extension UITextField {
    func setPlaceholderTextColor(_ color: UIColor) {
        guard let currentPlaceholder = self.placeholder else { return }
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color
        ]
        
        self.attributedPlaceholder = NSAttributedString(string: currentPlaceholder, attributes: attributes)
    }
}
