//
//  SplashScreenViewController.swift
//  MovieChallenge
//
//  Created by AnılKaramış on 25.12.2024.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    private let viewModel: SplashViewModel
    
    init(viewModel: SplashViewModel = .init()) {
        self.viewModel = viewModel
        super.init
    }
}

