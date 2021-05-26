//
//  ResponseOperation.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

public protocol ResponseOperation: NetworkOperationConvertible, Operation {
    func mapping(_ rawResponse: NetworkResponseProtocol) throws -> Response
}


public extension ResponseOperation {
    func asNetworkOperation() -> AnyNetworkOperation<Model> {
        return AnyNetworkOperation(
            request: { self.request },
            mapping: { rawResponse in try self.mapping(self.mapping(rawResponse)) }
        )
    }
}
