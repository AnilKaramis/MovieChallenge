//
//  SplashScreenViewModel.swift
//  MovieChallenge
//
//  Created by AnılKaramış on 25.12.2024.
//

import Foundation
import UIKit

final class SplashScreenViewModel {
    weak var input: SplashScreenInput?
    weak var output: SplashScreenOutput?
    
    init() { input = self }
    
    private func checkBookmarkedMovies() {
        let bookmarkedMovies: [Movie] = UserDefaultsManager.shared.get(key: Constants.UserDefaultConstants.favouritesKey)
        
        for endpoint in MovieListEndpoint.allCases {
            for movie in bookmarkedMovies {
                for i in 0..<(AppManager.shared.movies[endpoint]?.count ?? 0) {
                    if AppManager.shared.movies[endpoint]?[i].id == movie.id {
                        AppManager.shared.movies[endpoint]?[i].isFav = true
                    }
                }
            }
        }
    }
}

extension SplashScreenViewModel: SplashScreenInput {
    func viewDidLoad() {
        var count = 0
        let endpointCount = MovieListEndpoint.allCases.count
        for endpoint in MovieListEndpoint.allCases {
            MovieService.shared.fetchMovies(from: endpoint) { [weak self] (result) in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    AppManager.shared.movies[endpoint] = response.results
                    count += 1
                    if count == endpointCount {
                        self.checkBookmarkedMovies()
                        self.output?.createTabBar()
                    }
                case .failure(let error):
                    self.output?.showError(error: error)
                    return
                }
            }
        }
    }
}
