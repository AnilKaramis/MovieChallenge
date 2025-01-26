//
//  APIClient.swift
//  Teknasyon MVVM Template
//
//  Created by YusufDemirkoparan on 11.07.2024.
//

import Combine
import Foundation

public protocol NetworkClientService {
    func request<T: Decodable>(_ request: Request, response: T.Type) async throws -> T
}

public final class APIClient: NetworkClientService {
    
    private var urlSession: URLSession?
    
    public init() {}

    // Initialize URLSession with SSL Pinning
    public func initializeSessionManagers() {
        urlSession?.invalidateAndCancel()   ///Kendi Foundation URLSeassion iptal ediyor
        urlSession = URLSession(configuration: .default, delegate: SSLPinningURLSessionDelegate(), delegateQueue: nil) /// SSLPinningURLSessionDeelgate yeni URLSeassion delegate yapma
    }
    
    // Perform a network request and decode the response
    public func request<T: Decodable>(_ request: Request, response: T.Type) async throws -> T {
        guard let urlRequest = request.setUrlRequest(isRunningInBackground: true) else {
            throw RequestError.incorrectDataReturned
        }
        
        guard let urlSession = urlSession else {
            throw RequestError.noRequest
        }
        
        do {
            let (data, response) = try await urlSession.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw RequestError.incorrectDataReturned
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw RequestError.invalidStatusCode(httpResponse.statusCode)
            }
            
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch let error as URLError {
            throw RequestError.misFunctionedUrl(error)
        } catch {
            throw RequestError.parsingError(error)
        }
    }
}

