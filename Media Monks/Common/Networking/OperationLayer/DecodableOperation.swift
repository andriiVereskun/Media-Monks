//
//  DecodableOperation.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

public protocol DecodableResponseOperation: DataResponseOperation where Model: Decodable {}


public extension DecodableResponseOperation {
    
    func mapping(_ response: Response) throws -> Model {
        
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(Model.self, from: response as Data)
            return object
        }
        catch {
            throw NetworkError.serialization(.responseObjectIsNotJSON(error))
        }
        
    }
    
}

extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        return prettyPrintedString
    }
}
