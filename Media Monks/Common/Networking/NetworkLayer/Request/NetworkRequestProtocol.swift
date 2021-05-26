//
//  NetworkRequestProtocol.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

public enum MultipartObject {
    case file(name: String, file: URL, filename: String?, mimeType: String?)
    case data(name: String, data: Data, mimeType: String)
}

public enum NetworkRequestPayload {
    
    case none
    case formData(RequestParametersCollection)
    case query(RequestParametersCollection)
    case body(RequestBody)
    case multipart([MultipartObject])
    case video(MultipartObject)
}

public protocol NetworkRequestProtocol {
    
    var endpoint: String { get }
    var method: RequestMethod { get }
    var payload: NetworkRequestPayload { get set }
    var headers: RequestHeadersCollection? { get set }
    
    var shouldSign: Bool { get }
    var shouldHandleCookies: Bool { get }
    
    var cachePolicy: URLRequest.CachePolicy? { get }
    var timeout: TimeInterval? { get }
}
