//
//  Operation.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

public protocol Operation {
    associatedtype Response
    associatedtype Model
    
    var request: NetworkRequestProtocol { get }
    func mapping(_ response: Response) throws -> Model
}


public extension Operation where Response == Model {
    func mapping(_ response: Response) throws -> Model {
        return response
    }
}
