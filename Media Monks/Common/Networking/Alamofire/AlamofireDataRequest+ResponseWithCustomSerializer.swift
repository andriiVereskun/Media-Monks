//
//  AlamofireDataRequest+ResponseWithCustomSerializer.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation
import Alamofire

public extension Alamofire.DataRequest {
    
    func response<T: DataResponseSerializerProtocol>(
        using responseSerializer: T,
        completionBlock: @escaping (Result<(URLRequest, HTTPURLResponse, Data), NetworkError>) -> Void
    ) -> DataRequest {
        response(responseSerializer: responseSerializer) { response in
            if let error = response.error?.underlyingError as? NetworkError {
                completionBlock(.failure(error))
            } else if let error = response.error {
                completionBlock(.failure(.connection(.init(error: error))))
            } else if let req = response.request, let res = response.response {
                if let data = response.data {
                    completionBlock(.success((req, res, data)))
                } else if res.statusCode == 204 || res.statusCode == 200 {
                    completionBlock(.success((req, res, Data("success".utf8).base64EncodedData())))
                }
            }
        }
    }
}
