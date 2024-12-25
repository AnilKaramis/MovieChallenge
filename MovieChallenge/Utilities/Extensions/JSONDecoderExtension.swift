//
//  JSONDecoderExtension.swift
//  MovieChallenge
//
//  Created by AnılKaramış on 26.12.2024.
//

import Foundation

extension JSONDecoder {
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.movieDateFormatter)
        return jsonDecoder
    }()
}
