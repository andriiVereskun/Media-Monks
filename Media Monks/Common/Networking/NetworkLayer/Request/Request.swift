//
//  Request.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

public struct Request: NetworkRequestProtocol {
    
    public var endpoint: String
    public var method: RequestMethod
    public var payload: NetworkRequestPayload
    public var headers: RequestHeadersCollection?
    public var shouldSign: Bool
    public var shouldHandleCookies: Bool
    public var cachePolicy: URLRequest.CachePolicy?
    public var timeout: TimeInterval?
    
    public init(
        endpoint: String,
        method: RequestMethod,
        payload: NetworkRequestPayload = .none,
        headers: RequestHeadersCollection? = nil,
        shouldSign: Bool = false,
        shouldHandleCookies: Bool = true,
        cachePolicy: URLRequest.CachePolicy? = nil,
        timeout: TimeInterval? = nil)
    {
        self.endpoint = endpoint
        self.method = method
        self.payload = payload
        self.headers = headers
        self.shouldSign = shouldSign
        self.shouldHandleCookies = shouldHandleCookies
        self.cachePolicy = cachePolicy
        self.timeout = timeout
    }
}
