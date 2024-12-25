//
//  DateFormatterExtension.swift
//  MovieChallenge
//
//  Created by AnılKaramış on 26.12.2024.
//

import Foundation

extension DateFormatter {
    static let movieDateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-mm-dd"
            return dateFormatter
    }()
}
