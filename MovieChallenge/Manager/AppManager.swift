//
//  AppManager.swift
//  MovieChallenge
//
//  Created by AnılKaramış on 25.12.2024.
//

import Foundation
 
class AppManager {
    static let shared = AppManager()
    
    var movies = [MovieListEndpoint: [Movie]]()
    
    private init() {
        for endpoint in MovieListEndpoint.allCases {
            movies[endpoint] = [Movie]()
        }
    }
}
