//
//  JSONResponseOperation.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

public protocol JSONResponseOperation: ResponseOperation where Response == JSON {}

public extension JSONResponseOperation {
    func mapping(_ rawResponse: NetworkResponseProtocol) throws -> Response {
        let jsonObject: Any
        do {
            jsonObject = try JSONSerialization.jsonObject(with: rawResponse.data, options: .allowFragments)
        } catch {
            throw NetworkError.serialization(.responseDataNotSerializable(rawResponse.data, error))
        }
        guard let json = jsonObject as? JSON else {
            throw NetworkError.serialization(.responseObjectIsNotJSON(jsonObject))
        }
        return json
    }
}
