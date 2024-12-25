//
//  SplashScreenProtocol.swift
//  MovieChallenge
//
//  Created by AnılKaramış on 25.12.2024.
//

import Foundation

protocol SplashScreenInput: AnyObject {
    func viewDidLoad()
}

protocol SplashScreenOutput: AnyObject {
    func createTabBar()
    func showError(error: NetworkError)
}
