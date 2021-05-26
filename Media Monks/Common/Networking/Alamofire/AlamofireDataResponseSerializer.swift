//
//  AlamofireDataResponseSerializer.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation
import Alamofire

public struct AlamofireDataResponseSerializer: DataResponseSerializerProtocol {
    
    public func serialize(request: URLRequest?, response: HTTPURLResponse?, data: Data?, error: Error?) throws -> AFResult<Data> {
        var mappedError: NetworkError? = error.map { .unknown($0) }
        
        if let statusCode = response?.statusCode {
            var errors: ErrorResponse?
            if let data = data {
                errors = try? JSONDecoder().decode(ErrorResponse.self, from: data)
            }
            if let clientError = ClientErrorFailureReason(statusCode: statusCode, errorDetail: errors?.errors.first) {
                mappedError = .client(clientError)
            }
            else if let serverError = ServerErrorFailureReason(statusCode: statusCode) {
                mappedError = .server(serverError)
            }
            else if let connectionErrorReason = error.flatMap(ConnectionErrorFailureReason.init) {
                // TODO: Add parsing of AFNetworking errors here (cancelled, timeout, etc.)
                mappedError = .connection(connectionErrorReason)
            }
        }
        
        if error?.asAFError?.isExplicitlyCancelledError == true,
           let connectionErrorReason = error.flatMap(ConnectionErrorFailureReason.init) {
            mappedError = .connection(connectionErrorReason)
        }
        
        if let mappedError = mappedError {
            throw AFError.responseSerializationFailed(reason: .decodingFailed(error: mappedError))
        } else if let data = data {
            return .success(data)
        } else if data == nil {
            return .success(Data("success".utf8).base64EncodedData())
        }

        throw AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
    }
}
