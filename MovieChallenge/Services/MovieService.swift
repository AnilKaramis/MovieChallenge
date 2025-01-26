//
//  MovieService.swift
//  MovieChallenge
//
//  Created by AnılKaramış on 26.12.2024.
//

import Foundation
import NetworkLayer

protocol MovieServiceProtocol {
    func fetchMovies(from endpoint: MovieListEndpoint,completion: @escaping (Result<MovieResponse, NetworkError>) -> ())
    func fetchGenres(completion: @escaping (Result<GenreResponse, NetworkError>) -> ())
}

class MovieService: MovieServiceProtocol {
    static let shared = MovieService()
    private init() {}
    
    private let movieFetchURL = Constants.APIConstants.baseAPIURL + "/movie"
    private let genreFetchURL = Constants.APIConstants.baseAPIURL + "/genre/movie/list"
    
    func fetchMovies(from endpoint: MovieListEndpoint, completion: @escaping (Result<MovieResponse, NetworkError>) -> ()) {
        guard let url = URL(string: "\(movieFetchURL)/\(endpoint.rawValue)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        ServiceManager.shared.fetch(url: url, params: [
            "language": "en-US",
            "page": "1",
            "include_adult": "false"
        ], completion: completion)
    }
    
    func fetchGenres(completion: @escaping (Result<GenreResponse, NetworkError>) -> ()) {
        guard let url = URL(string: genreFetchURL) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        ServiceManager.shared.fetch(url: url, params: [
            "language": "en-US",
        ], completion: completion)
    }
//    func loadMoreMovies(page: Int, completion: @escaping (Bool) -> Void) {
//        // API çağrısı
//        ServiceManager.shared.(.nowPlaying(page: page)) { [weak self] result in
//            switch result {
//            case .success(let movies):
//                self?.movies.append(contentsOf: movies)
//                completion(true)
//            case .failure:
//                completion(false)
//            }
//        }
//    }
}
