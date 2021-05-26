//
//  NetworkService.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

public struct NetworkService: NetworkServiceProtocol {
    
    public struct Configuration {
        
        public let name: String
        public let url: URL
        public var headers: RequestHeadersCollection = [:]
        public var cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
        public var timeout: TimeInterval = 30.0
        
        public init(name: String? = nil, baseURL url: URL, headers: RequestHeadersCollection = [:]) {
            self.url = url
            self.name = name ?? url.host ?? ""
            self.headers = headers
        }
    }
    
    let requestDispatcher: NetworkRequestDispatcherProtocol
    public internal(set) var configuration: Configuration
    
    init(configuration: Configuration,
         dispatcher: NetworkRequestDispatcherProtocol) {
        self.configuration = configuration
        self.requestDispatcher = dispatcher
    }
    
    @discardableResult
    public func execute<O: Operation>(
        _ operation: O,
        completionBlock: @escaping (Result<O.Model, NetworkError>) -> Void
    ) -> CancellableRequest? where O.Response == NetworkResponseProtocol
    {
        execute(operation, progressBlock: { _ in }, completionBlock: completionBlock)
    }

    @discardableResult
    public func execute<O: Operation>(
        _ operation: O,
        progressBlock: @escaping (Progress) -> Void,
        completionBlock: @escaping (Result<O.Model, NetworkError>) -> Void
    ) -> CancellableRequest? where O.Response == NetworkResponseProtocol
    {
        execute(operation.request, progressBlock: progressBlock) { result in
            completionBlock(result.flatMapValue {
                do {
                    return .success(try operation.mapping($0))
                }
                catch let error as NetworkError {
                    return .failure(error)
                }
                catch {
                    return .failure(.unknown(error))
                }
            })
        }
    }
    
    @discardableResult
    func execute(_ networkRequest: NetworkRequestProtocol,
                 completionBlock: @escaping (Result<NetworkResponseProtocol, NetworkError>) -> Void) -> CancellableRequest? {
        execute(networkRequest, progressBlock: { _ in }, completionBlock: completionBlock)
    }
    
    @discardableResult
    public func execute(
        _ networkRequest: NetworkRequestProtocol,
        progressBlock: @escaping (Progress) -> Void,
        completionBlock: @escaping (Result<NetworkResponseProtocol, NetworkError>) -> Void
    ) -> CancellableRequest? {
        requestDispatcher.execute(networkRequest,
                                  configuration: configuration,
                                  progressBlock: progressBlock, completionBlock: { result in
            let mappedResult = result.mapValue { (_, urlResponse, data) in
                return Response(
                    data: data,
                    request: networkRequest,
                    httpResponse: urlResponse,
                    status: ResponseStatus(code: urlResponse.statusCode)
                ) as NetworkResponseProtocol
            }
            completionBlock(mappedResult)
        })
    }
}

extension NetworkService.Configuration: CustomStringConvertible {
    public var description: String {
        return "\(name): \(url.absoluteString)"
    }
}

extension NetworkService.Configuration {
    
    public enum Option: String {
        case endpoint, name, base, headers
    }
    
    public static func appConfig() -> NetworkService.Configuration? {
        return NetworkService.Configuration()
    }
    
    init?() {
        // It must be a dictionary of this type ```{ "endpoint" : { "base" : "host.com/api/v1" } }```
        guard let appServiceConfig = Bundle.main.object(forInfoDictionaryKey: Option.endpoint.rawValue) as? JSON,
              let baseURLString = appServiceConfig[Option.base.rawValue] as? String,
              let baseURL = URL(string: baseURLString)
        else {
            return nil
        }
        
        let name = appServiceConfig[Option.name.rawValue] as? String
        self.init(name: name, baseURL: baseURL)
        
        if let fixedHeaders = appServiceConfig[Option.headers.rawValue] as? RequestHeadersCollection {
            self.headers = fixedHeaders
        }
    }
}
