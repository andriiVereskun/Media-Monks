//
//  ConnectionErrorFailureReason.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

public enum ConnectionErrorFailureReason {
    case emptyResponse
    case networkConnectionLost
    case timeOut
    case serverUnavailable
    case cancelled
    case other(Swift.Error)
    
    init(error: Swift.Error) {
        guard let urlError = error as? URLError else {
            self = .other(error)
            return
        }
        switch urlError.code {
        case .notConnectedToInternet,
             .networkConnectionLost,
             .cannotFindHost:
            self = .networkConnectionLost
        case .timedOut:
            self = .timeOut
        case .badServerResponse, .resourceUnavailable:
            self = .serverUnavailable
        case .cancelled:
            self = .cancelled
        default:
            self = .other(error)
        }
    }
    
}
    
extension ConnectionErrorFailureReason: PatternEquatable {
    
    public static func %= (lhs: ConnectionErrorFailureReason, rhs: ConnectionErrorFailureReason) -> Bool {
        switch (lhs, rhs) {
        case (.emptyResponse, .emptyResponse): return true
        case (.networkConnectionLost, .networkConnectionLost): return true
        case (.timeOut, .timeOut): return true
        case (.serverUnavailable, .serverUnavailable): return true
        case (.cancelled, .cancelled): return true
        case (.other, .other): return true
        default:
            return false
        }
    }
    
}


extension ConnectionErrorFailureReason: CustomStringConvertible {
    public var description: String {
        switch self {
        case .emptyResponse:
            return "Empty response"
        case .networkConnectionLost:
            return "Network connection lost"
        case .timeOut:
            return "Timeout"
        case .serverUnavailable:
            return "Server is unavailable"
        case .cancelled:
            return "Cancelled"
        case .other(let error):
            return "Other: " + error.localizedDescription
        }
    }
}
