//
//  APIRequestError.swift
//  Teknasyon MVVM Template
//
//  Created by YusufDemirkoparan on 11.07.2024.
//

import Foundation

public enum RequestError: Error {
    case unknown(NSError)
    case misFunctionedUrl(URLError)
    case notConnectedToInternet
    case notReachedServer
    case connectionLost
    case noRequest
    case incorrectDataReturned
    case parsingError(Error)
    case invalidStatusCode(Int)

    var message: String {
        switch self {
        case .unknown, .incorrectDataReturned:
            return "Something went wrong."
        case .notConnectedToInternet, .notReachedServer, .connectionLost:
            return "Network error occurred."
        case let .invalidStatusCode(statusCode):
            return "\(statusCode) with invalid status code error occurred."
        case let .misFunctionedUrl(urlError):
            return "\(urlError.localizedDescription) in the URL error domain."
        case let .parsingError(parsingError):
            return "\(parsingError.localizedDescription) parsing error."
        case .noRequest:
            return "There is no URLSession."
        }
    }
}
