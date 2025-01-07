//
//  ApiConstants.swift
//  Teknasyon MVVM Template
//
//  Created by YusufDemirkoparan on 11.07.2024.
//

import Foundation

public struct ApiConstants {
    public static let apiScheme: String = "https"
    public static let apiHost: String = "api.themoviedb.org"
    public static let baseUrl: String = "v1/"
    
    public enum Path: String {
        case cards
    }
}
