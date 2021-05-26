//
//  SerializationErrorFailureReason.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

public enum SerializationErrorFailureReason {
    case requestIsNotEncodable(Any?)
    case responseDataNotSerializable(Data, Swift.Error)
    case responseObjectIsNotJSON(Any)
    case other(Error)
}


extension SerializationErrorFailureReason: PatternEquatable {
    public static func %= (lhs: SerializationErrorFailureReason, rhs: SerializationErrorFailureReason) -> Bool {
        switch (lhs, rhs) {
        case (.requestIsNotEncodable, .requestIsNotEncodable): return true
        case (.responseDataNotSerializable, .responseDataNotSerializable): return true
        case (.responseObjectIsNotJSON, .responseObjectIsNotJSON): return true
        default:
            return false
        }
    }
}

extension SerializationErrorFailureReason: CustomStringConvertible {
    public var description: String {
        switch self {
        case .requestIsNotEncodable(let requestData):
            return "Request is not encodable. " + String(describing: requestData)
        case .responseDataNotSerializable(let responseData, let underlyingError):
            return "Response data is not serializable. \(responseData). \(underlyingError)"
        case .responseObjectIsNotJSON(let object):
            return "Response object is not JSON. \(object)"
        case .other(let error):
            return "Unknown error. \(error)"
        }
    }
}
