//
//  APIRequestBuilder.swift
//  Teknasyon MVVM Template
//
//  Created by YusufDemirkoparan on 11.07.2024.
//

import Foundation

public enum HttpMethod: String {
    case put = "PUT"
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

public final class RequestBuilder {
    private let path: ApiConstants.Path
    private let lang: String
    var parameters: [String: Any]?
    var method: HttpMethod = .get
    var bodyData: Data?
    var headers: [HTTPHeader] = []

    private var retryCount: Int = 3
    private var retryDelay: TimeInterval = 1.0

    public init(_ path: ApiConstants.Path) {
        self.path = path
        lang = String(Locale.preferredLanguages[0].prefix(2))
    }

    @discardableResult
    public func method(_ method: HttpMethod) -> RequestBuilder {
        self.method = method
        return self
    }

    @discardableResult
    public func retryCount(_ retryCount: Int) -> RequestBuilder {
        self.retryCount = retryCount
        return self
    }

    @discardableResult
    public func retryDelay(_ retryDelay: TimeInterval) -> RequestBuilder {
        self.retryDelay = retryDelay
        return self
    }

    @discardableResult
    public func parameters(_ parameters: [String: Any]) -> RequestBuilder {
        self.parameters = parameters
        return self
    }

    @discardableResult
    public func bodyData(_ bodyDict: [String: Any]) -> RequestBuilder {
        if let bodyData = convertToJSONData(bodyDict) {
            self.bodyData = bodyData
        }
        return self
    }

    public func buildFullUrl() -> Request {
        Request(path: "\(ApiConstants.baseUrl)\(path)", parameters: parameters, method: method, bodyData: bodyData, headers: headers, retryCount: retryCount, retryDelay: retryDelay)
        
        
    }

    public func build() -> Request {
        let requestPath = "\(ApiConstants.baseUrl)\(path)"
        Log.info("request path:\(requestPath)")

        return Request(path: requestPath, parameters: parameters, method: method, bodyData: bodyData, headers: headers, retryCount: retryCount, retryDelay: retryDelay)
    }

    private func convertToJSONData(_ dictionary: [String: Any]) -> Data? {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: []) else {
            return nil
        }
        return jsonData
    }
}
