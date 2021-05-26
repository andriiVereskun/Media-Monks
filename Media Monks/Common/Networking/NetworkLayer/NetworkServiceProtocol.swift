//
//  NetworkServiceProtocol.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

protocol NetworkServiceProtocol {
    @discardableResult
    func execute<O: Operation>(
        _ operation: O,
        completionBlock: @escaping (Result<O.Model, NetworkError>) -> Void
    ) -> CancellableRequest? where O.Response == NetworkResponseProtocol
    
    @discardableResult
    func execute<O: Operation>(
        _ operation: O,
        progressBlock: @escaping (Progress) -> Void,
        completionBlock: @escaping (Result<O.Model, NetworkError>) -> Void
    ) -> CancellableRequest? where O.Response == NetworkResponseProtocol
    
    @discardableResult
    func execute(
        _ networkRequest: NetworkRequestProtocol,
        completionBlock: @escaping (Result<NetworkResponseProtocol, NetworkError>) -> Void
    ) -> CancellableRequest?
    
    @discardableResult
    func execute(
        _ networkRequest: NetworkRequestProtocol,
        progressBlock: @escaping (Progress) -> Void,
        completionBlock: @escaping (Result<NetworkResponseProtocol, NetworkError>) -> Void
    ) -> CancellableRequest?
}

