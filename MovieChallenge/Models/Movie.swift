//
//  Movie.swift
//  MovieChallenge
//
//  Created by AnılKaramış on 26.12.2024.
//

import Foundation

struct Movie: Codable {
    
    let id: Int
    let title: String
    let year: String
    let rate: Double
    let posterImage: String
    let backdropImage: String
    let overview: String
    let genres: [Int]
    var isFav = false
    
    private enum CodingKeys: String, CodingKey {
        case id, title, overview
        case year = "release_date"
        case rate = "vote_average"
        case posterImage = "poster_path"
        case backdropImage = "backdrop_path"
        case genres = "genre_ids"
    }
}

extension Movie {
    func getGenreNames() -> [String] {
        let genreDict: [Int: String] = AppManager.shared.genres.reduce(into: [Int: String]()) { $0[$1.id] = $1.name }
        var genreNames = [String]()
        for genre in genres {
            genreNames += [(genreDict[genre] ?? "All")]
        }
        return genreNames
    }
}
