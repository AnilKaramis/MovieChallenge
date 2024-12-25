//
//  BookmarksViewModel.swift
//  MovieChallenge
//
//  Created by AnılKaramış on 26.12.2024.
//

import Foundation

final class BookmarksViewModel {
    private(set) var favouriteMovies = [Movie]()
    
    init() {
        getMoviesFromUserDefaults()
    }
    
    func getMoviesFromUserDefaults() {
        favouriteMovies = UserDefaultsManager.shared.get(key: Constants.UserDefaultConstants.favouritesKey)
    }
}
