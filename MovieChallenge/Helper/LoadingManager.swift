//
//  LoadingManager.swift
//  MovieChallenge
//
//  Created by AnılKaramış on 3.01.2025.
//

import UIKit

class LoadingManager {
    static let shared = LoadingManager()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.backgroundColor = .systemBackground.withAlphaComponent(0.7)
        return indicator
    }()
    
    func showLoading(in view: UIView) {
        
        DispatchQueue.main.async {
            self.loadingIndicator.frame = view.bounds
            view.addSubview(self.loadingIndicator)
            self.loadingIndicator.startAnimating()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.removeFromSuperview()
        }
    }
}
