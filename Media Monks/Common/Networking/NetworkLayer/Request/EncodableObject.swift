//
//  EncodableObject.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

import Foundation

public protocol EncodableObject {
    
    func encode() throws -> Data
}

public struct SwiftEncodableObject<T: Encodable>: EncodableObject {
    
    public let object: T
    
    public init(_ object: T) {
        self.object = object
    }
    
    public func encode() throws -> Data {
        return try JSONEncoder().encode(object)
    }
    
}

public struct JSONSerializableObject: EncodableObject {
    
    public let object: Any
    
    public init(_ object: Any) {
        self.object = object
    }
    
    public func encode() throws -> Data {
        return try JSONSerialization.data(withJSONObject: object, options: [])
    }
}
