//
//  UIMenu.swift
//  MovieChallenge
//
//  Created by AnılKaramış on 26.12.2024.
//

import UIKit

extension UIMenu {
    convenience init(menuTitle: String ,titles: [String], handler: @escaping ((String) -> Void)) {
        var actions = [UIAction]()
        for title in titles {
            actions.append(UIAction(title: title, handler: { action in handler(action.title) }))
        }
        self.init(title: menuTitle, children: actions)
    }
}
