//
//  APIRequest.swift
//  Teknasyon MVVM Template
//
//  Created by YusufDemirkoparan on 11.07.2024.
//

import Foundation

public struct Request {
    private let path: String
    private let parameters: [String: Any]?
    private let method: HttpMethod
    private var bodyData: Data?
    private let headers: [HTTPHeader]
    private(set) var retryCount: Int
    private(set) var retryDelay: TimeInterval

    init(path: String,
         parameters: [String: Any]?,
         method: HttpMethod,
         bodyData: Data?,
         headers: [HTTPHeader] = NetworkDefaults.defaultHeaders(),
         retryCount: Int,
         retryDelay: TimeInterval) {
        self.path = path
        self.parameters = parameters
        self.method = method
        self.bodyData = bodyData
        self.headers = headers
        self.retryCount = retryCount
        self.retryDelay = retryDelay
    }

    
    func setUrlRequest(isRunningInBackground: Bool) -> URLRequest? {
        guard let url = NetworkDefaults.urlComponents(with: path, parameters: parameters).url else { Log.error("error \(#line)"); return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        headerHandler(urlRequest: &request, header: headers)

        if let bodyData = bodyData {
            request.httpBody = bodyData
        }

        Log.info("\(request.url?.absoluteString ?? "")")

        return request
    }

    private func headerHandler(urlRequest: inout URLRequest, header: [HTTPHeader]?) {
        var allHeaders: [HTTPHeader] = header ?? []
        allHeaders.append(contentsOf: NetworkDefaults.defaultHeaders())

        allHeaders.forEach { item in
            urlRequest.addValue(item.value, forHTTPHeaderField: item.name)
        }
    }
}
