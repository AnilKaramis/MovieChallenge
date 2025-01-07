//
//  MockURLSession.swift
//  Teknasyon MVVM Template
//
//  Created by YusufDemirkoparan on 11.07.2024.
//

import Foundation

class MockURLSession: URLProtocol {
    
    static var stubResponseData: Data?
    static var stubURLResponse: HTTPURLResponse?
    static var stubError: Error?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let stubError = MockURLSession.stubError {
            self.client?.urlProtocol(self, didFailWithError: stubError)
        } else {
            self.client?.urlProtocol(self, didLoad: MockURLSession.stubResponseData ?? Data())
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
}
