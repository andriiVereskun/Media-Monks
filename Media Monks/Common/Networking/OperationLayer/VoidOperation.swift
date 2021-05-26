//
//  VoidOperation.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

public protocol VoidOperation: ResponseOperation where Response == Void, Model == Void {}


public extension VoidOperation {
    func mapping(_ rawResponse: NetworkResponseProtocol) throws -> Response {
        return ()
    }
}
