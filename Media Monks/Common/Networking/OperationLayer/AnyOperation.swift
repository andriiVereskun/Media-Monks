//
//  AnyOperation.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

public struct AnyOperation<Response, Model> {
    fileprivate let getRequest: () -> NetworkRequestProtocol
    fileprivate let map: Mapping<Response, Model>
    
    public init<O: NetworkOperation>(_ base: O) where O.Response == Response, O.Model == Model {
        getRequest = { base.request }
        map = base.mapping
    }
    
    public init(request requestGetter: @escaping () -> NetworkRequestProtocol, mapping: @escaping Mapping<Response, Model>) {
        getRequest = requestGetter
        map = mapping
    }
}


extension AnyOperation: Operation {
    public var request: NetworkRequestProtocol {
        get {
            return getRequest()
        }
    }
    
    public func mapping(_ response: Response) throws -> Model {
        return try map(response)
    }
}
