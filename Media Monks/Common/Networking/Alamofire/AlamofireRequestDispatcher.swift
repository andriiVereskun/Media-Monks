//
//  AlamofireRequestDispatcher.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation
import Alamofire

public struct AlamofireRequestDispatcher: NetworkRequestDispatcherProtocol {
    
    public let session: Alamofire.Session
    public let responseSerializer = AlamofireDataResponseSerializer()
        
    public init(session: Alamofire.Session = .default) {
        self.session = session
    }
    
    public func execute(
        _ request: NetworkRequestProtocol,
        configuration: NetworkService.Configuration,
        progressBlock: @escaping (Progress) -> Void,
        completionBlock: @escaping (Result<(URLRequest, HTTPURLResponse, Data), NetworkError>) -> Void) -> CancellableRequest?
    {
        let result = serialize(request: request, configuration: configuration)
        switch result {
            case .success(let serializedRequest):
                return serializedRequest
                    .validate().uploadProgress(closure: progressBlock)
                    .response(using: self.responseSerializer, completionBlock: completionBlock)
            case .failure(let reason):
                completionBlock(.failure(.serialization(reason)))
                return nil
        }
    }
    
    private func serialize(
        request: NetworkRequestProtocol,
        configuration: NetworkService.Configuration) -> Result<DataRequest, SerializationErrorFailureReason>
    {
        guard let url = URL(string: request.endpoint, relativeTo: configuration.url) else {
            return .failure(.requestIsNotEncodable("Invalid request endpoint"))
        }
        
        do {
            var urlRequest = try URLRequest(
                url: url,
                method: request.method.alamofireMethod,
                headers: HTTPHeaders(request.headers ?? [:]))
            
            urlRequest.cachePolicy = request.cachePolicy ?? configuration.cachePolicy
            urlRequest.timeoutInterval = request.timeout ?? configuration.timeout
            urlRequest.httpShouldHandleCookies = request.shouldHandleCookies
            
            switch request.payload {
            case .none:
                return .success(session.request(urlRequest))
            case .formData(let parameters):
                let encodedURLRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
                return .success(session.request(encodedURLRequest))
            case .query(let parameters):
                let encodedURLRequest = try URLEncoding.queryString.encode(urlRequest, with: parameters)
                return .success(session.request(encodedURLRequest))
            case .body(let requestBody):
                let serializationResult = requestBody.encodedData()
                if let reason = serializationResult.error {
                    return .failure(reason)
                } else {
                    serializationResult.mapValue { urlRequest.httpBody = $0 }
                    return .success(session.request(urlRequest))
                }
            case .multipart(let multipartObjects):
                let multipartHandler = { (multipart: MultipartFormData) in
                    self.appendMultipartObjects(multipartObjects, to: multipart)
                }
                return .success(session.upload(multipartFormData: multipartHandler, with: urlRequest))
            case .video(let multipartObject):
                switch multipartObject {
                case .file(_, let file, _, _):
                    return .success(session.upload(file,
                                                   with: urlRequest,
                                                   interceptor: nil,
                                                   fileManager: .default))
                case .data(_, let data, _):
                    return .success(session.upload(data,
                                                   with: urlRequest,
                                                   interceptor: nil,
                                                   fileManager: .default))
                }
            }
        }
        catch {
            return .failure(.requestIsNotEncodable(error))
        }
    }
    
    private func appendMultipartObjects(_ multipartObjects: [MultipartObject], to multipart: MultipartFormData) {
        for object in multipartObjects {
            switch object {
            case .file(let name, let url, let filename, let mimeType):
                if let filename = filename, let mimeType = mimeType {
                    multipart.append(url, withName: name, fileName: filename, mimeType: mimeType)
                }
                else {
                    multipart.append(url, withName: name)
                }
                
            case .data(let name, let data, let mimeType):
                multipart.append(data, withName: name, mimeType: mimeType)
            }
        }
    }
}
