//
//  Response.swift
//  MovieChallenge
//
//  Created by AnılKaramış on 26.12.2024.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
}

struct GenreResponse: Codable {
    let genres: [Genre]
}
