//
//  RequestBody.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

public enum RequestBody {
    
    public typealias CustomEncoder = (Any) -> Result<Data, SerializationErrorFailureReason>
    
    case rawData(Data)
    case rawString(String, String.Encoding)
    case json(EncodableObject)
    case urlEncoded(RequestParametersCollection, String.Encoding)
    case custom(data: Any, encoder: CustomEncoder)
    
    var data: Any {
        switch self {
        case .rawData(let data):
            return data
        case .rawString(let string, _):
            return string
        case .json(let json):
            return json
        case .urlEncoded(let params, _):
            return params
        case .custom(let any, _):
            return any
        }
    }
    
    func encodedData() -> PregsenseCommonResult<Data, SerializationErrorFailureReason> {
        switch self {
        case .rawData(let data):
            return .success(data)
            
        case .rawString(let string, let encoding):
            guard let encodedData = string.data(using: encoding) else {
                return .failure(.requestIsNotEncodable(string))
            }
            return .success(encodedData)
            
        case .json(let object):
            do {
                let serializedData = try object.encode()
                return .success(serializedData)
            }
            catch {
                return .failure(.requestIsNotEncodable(object))
            }
            
        case .urlEncoded(let params, let encoding):
            guard let encodedURLParametersData = params.asURLEncodedString()?.data(using: encoding) else {
                return .failure(.requestIsNotEncodable(params))
            }
            return .success(encodedURLParametersData)
            
        case .custom(let any, let encodingFunc):
            return encodingFunc(any)
        }
    }
    
}

