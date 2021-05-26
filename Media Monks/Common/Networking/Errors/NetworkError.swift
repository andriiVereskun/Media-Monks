//
//  NetworkError.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

public enum NetworkError: Swift.Error, CustomStringConvertible {
    case client(ClientErrorFailureReason)
    case server(ServerErrorFailureReason)
    case connection(ConnectionErrorFailureReason)
    case serialization(SerializationErrorFailureReason)
    case unknown(Swift.Error?)
    
    public var localizedDescription: String {
        // TODO: localization needed here (not urgently)
        return description
    }
    
    public var description: String {
        switch self {
        case .client(let reason):
            return reason.description
        case .server(let reason):
            return reason.description
        case .connection(let reason):
            return "Connection error: " + reason.description
        case .serialization(let reason):
            return "Serialization error: " + reason.description
        case .unknown(let error):
            return "Unknown error: " + (error?.localizedDescription ?? "nil")
        }
    }

    public var errorInfo: ValidationError? {
        switch self {
        case .client(let reason):
            return reason.errorInfo
        case .server(_):
            return nil
        case .connection(_):
            return nil
        case .serialization(_):
            return nil
        case .unknown(_):
            return nil
        }
    }
    
    public var isCancelled: Bool {
        guard
            case .connection(let reason) = self,
            case .other(let err) = reason,
            err.asAFError?.isExplicitlyCancelledError == true
        else { return false }
        
        return true
    }
}

extension NetworkError: PatternEquatable {
    public static func %= (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.client(let reason1), .client(let reason2)): return reason1 == reason2
        case (.server(let reason1), .server(let reason2)): return reason1 == reason2
        case (.connection(let reason1), .connection(let reason2)): return reason1 %= reason2
        case (.serialization(let reason1), .serialization(let reason2)): return reason1 %= reason2
        case (.unknown, .unknown): return true
        default:
            return false
        }
    }
    
    public static func !%= (testable: NetworkError, test: NetworkError) -> Bool {
        return !(testable %= test)
    }
}
