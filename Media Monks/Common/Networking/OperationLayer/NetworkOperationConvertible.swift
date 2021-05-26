//
//  NetworkOperationConvertible.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation
import Alamofire

public typealias AnyNetworkOperation<Model> = AnyOperation<NetworkResponseProtocol, Model>

public protocol NetworkOperationConvertible {
    
    associatedtype Model
    func asNetworkOperation() -> AnyNetworkOperation<Model>
    
}

extension NetworkServiceProtocol {
    func execute<C: NetworkOperationConvertible>(
        _ convertible: C,
        completionBlock: @escaping (Result<C.Model, NetworkError>) -> Void)
    {
        execute(convertible.asNetworkOperation(), completionBlock: completionBlock)
    }
}
