//
//  Response.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

public struct Response: NetworkResponseProtocol {
    public var data: Data
    public var request: NetworkRequestProtocol
    public var httpResponse: HTTPURLResponse?
    public var status: ResponseStatus
}
