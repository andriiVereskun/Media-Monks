//
//  ValidationError.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

public struct ValidationError: Decodable {
    let detail: String
    let status: Int
    let code: Int
    
    private enum CodingKeys: String, CodingKey {
        case detail
        case status
        case code
    }
}

