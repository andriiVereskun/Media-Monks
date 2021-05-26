//
//  NetworkResponseProtocol.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

public protocol NetworkResponseProtocol {
    var data: Data { get }
    var status: ResponseStatus { get }
    var request: NetworkRequestProtocol { get }
    var httpResponse: HTTPURLResponse? { get }
}
