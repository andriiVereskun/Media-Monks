//
//  DataResponseOperation.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

public protocol DataResponseOperation: ResponseOperation where Response == Data {}

public extension DataResponseOperation {
    func mapping(_ rawResponse: NetworkResponseProtocol) throws -> Response {
        return rawResponse.data
    }
}

