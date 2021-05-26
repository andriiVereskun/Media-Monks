//
//  ServerErrorFailureReason.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

public enum ServerErrorFailureReason {
    case `internal`
    case notImplemented
    case serviceUnavailable
    case other(statusCode: Int)
    
    init?(statusCode: Int) {
        switch statusCode {
        case 500: self = .internal
        case 501: self = .notImplemented
        case 503: self = .serviceUnavailable
        case 500..<600: self = .other(statusCode: statusCode)
        default:
            return nil
        }
    }
}


extension ServerErrorFailureReason: Equatable {
    public static func == (lhs: ServerErrorFailureReason, rhs: ServerErrorFailureReason) -> Bool {
        switch (lhs, rhs) {
        case (.internal, .internal): return true
        case (.notImplemented, .notImplemented): return true
        case (.serviceUnavailable, .serviceUnavailable): return true
        case (.other(let statusCodeLHS), .other(let statusCodeRHS)):
            return statusCodeLHS == statusCodeRHS
        default:
            return false
        }
    }
}


extension ServerErrorFailureReason: CustomStringConvertible {
    public var description: String {
        switch self {
        case .internal:
            return "Client error: " + "500 Internal error"
        case .notImplemented:
            return "Client error: " + "501 Not Implemented"
        case .serviceUnavailable:
            return  "Client error: " + "503 Service unavailable"
        case .other(let statusCode):
            return "HTTP \(statusCode)"
        }
    }
}
