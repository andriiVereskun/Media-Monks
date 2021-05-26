//
//  ClientErrorFailureReason.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

public enum ClientErrorFailureReason {
    
    case badRequest(validationError: ValidationError?)
    case unauthorized(validationError: ValidationError?)
    case forbidden(validationError: ValidationError?)
    case notFound(validationError: ValidationError?)
    case notAcceptableMethod(validationError: ValidationError?)
    case other(statusCode: Int, validationError: ValidationError?)
    
    init?(statusCode: Int, errorDetail: ValidationError?) {
        switch statusCode {
        case 400: self = .badRequest(validationError: errorDetail)
        case 401: self = .unauthorized(validationError: errorDetail)
        case 403: self = .forbidden(validationError: errorDetail)
        case 404: self = .notFound(validationError: errorDetail)
        case 405: self = .notAcceptableMethod(validationError: errorDetail)
        case 400..<500: self = .other(statusCode: statusCode, validationError: errorDetail)
        default:
            return nil
        }
    }
    
}


extension ClientErrorFailureReason: Equatable {
    
    public static func == (lhs: ClientErrorFailureReason, rhs: ClientErrorFailureReason) -> Bool {
        switch (lhs, rhs) {
        case (.badRequest, .badRequest): return true
        case (.unauthorized, .unauthorized): return true
        case (.forbidden, .forbidden): return true
        case (.notFound, .notFound): return true
        case (.notAcceptableMethod, .notAcceptableMethod): return true
        case (.other(let statusCodeLHS, _), .other(let statusCodeRHS, _)):
            return statusCodeLHS == statusCodeRHS
        default:
            return false
        }
    }
    
}


extension ClientErrorFailureReason: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .badRequest(let validationError):
            if let validationError = validationError {
                return "\(validationError.detail)"
            } else {
                return "Client error: " + "400 Bad request"
            }
        case .unauthorized(let validationError):
            if let validationError = validationError {
                return "\(validationError.detail)"
            } else {
                return "Client error: " + "401 Unauthorized"
            }
        case .forbidden(let validationError):
            if let validationError = validationError {
                return "\(validationError.detail)"
            } else {
                return "Client error: " + "403 Forbidden"
            }
        case .notFound(let validationError):
            if let validationError = validationError {
                return "\(validationError.detail)"
            } else {
                return "Client error: " + "404 Not found"
            }
        case .notAcceptableMethod(let validationError):
            if let validationError = validationError {
                return "\(validationError.detail)"
            } else {
                return "Client error: " + "405 Method not allowed"
                
            }
        case .other(let statusCode, let validationError):
            if let validationError = validationError {
                return "\(validationError.detail)"
            } else {
                return "HTTP \(statusCode)"
            }
        }
    }
    
    public var errorInfo: ValidationError? {
        switch self {
        case .badRequest(let validationError):
            return validationError
        case .unauthorized(let validationError):
            return validationError
        case .forbidden(let validationError):
            return validationError
        case .notFound(let validationError):
            return validationError
        case .notAcceptableMethod(let validationError):
            return validationError
        case .other(_, let validationError):
            return validationError
        }
    }
}
