//
//  ResponseStatus.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

public struct ResponseStatus {
    public let code: ResponseStatusCode
    
    public var isSuccess: Bool {
        return (200..<300).contains(code)
    }
    
    public init(code: ResponseStatusCode) {
        self.code = code
    }
}
