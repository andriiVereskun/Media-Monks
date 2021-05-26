//
//  JSONDictionary+URLEncoding.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

public extension Dictionary where Key == String, Value == Any {
    
    func asURLQueryItems() -> [URLQueryItem] {
        return map { (arg) -> URLQueryItem in
            let (key, value) = arg
            return URLQueryItem(name: key, value: String(describing: value))
        }
    }
    
    func asURLEncodedString() -> String? {
        var urlComponents = URLComponents()
        urlComponents.queryItems = asURLQueryItems()
        return urlComponents.url?.absoluteString
    }
    
}
