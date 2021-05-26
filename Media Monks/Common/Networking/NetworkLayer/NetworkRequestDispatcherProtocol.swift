//
//  NetworkRequestDispatcherProtocol.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

protocol NetworkRequestDispatcherProtocol {
    func execute(
        _ request: NetworkRequestProtocol,
        configuration: NetworkService.Configuration,
        progressBlock: @escaping (Progress) -> Void,
        completionBlock: @escaping (Result<(URLRequest, HTTPURLResponse, Data), NetworkError>) -> Void
    ) -> CancellableRequest?
}

