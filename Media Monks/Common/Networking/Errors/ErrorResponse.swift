//
//  ErrorResponse.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

public struct ErrorResponse: Decodable {
    let errors: [ValidationError]
    
    private enum CodingKeys: String, CodingKey {
        case errors
    }
}
