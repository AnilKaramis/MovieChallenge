//
//  MovieService.swift
//  MovieChallenge
//
//  Created by AnılKaramış on 26.12.2024.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchMovies(from endpoint: MovieListEndpoint,completion: @escaping (Result<Response, MovieError>) -> ())
}

class MovieService: GenericNetworkService, MovieServiceProtocol {
    static let shared = MovieService()
    
    private let movieFetchURL = Constants.APIConstants.baseAPIURL + "/movie"
    
    func fetchMovies(from endpoint: MovieListEndpoint, completion: @escaping (Result<Response, MovieError>) -> ()) {
        guard let url = URL(string: "\(movieFetchURL)/\(endpoint.rawValue)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        fetch(url: url, params: [
            "language": "en-US",
            "page": "1",
            "include_adult": "false"
        ], completion: completion)
    }
}
