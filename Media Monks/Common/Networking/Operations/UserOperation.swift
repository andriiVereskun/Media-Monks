//
//  UserOperation.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/25/21.
//

import Foundation
import Alamofire

struct UserModel: Decodable {
    
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
    let address: AddressModel
    
    private enum CodingKeys: String, CodingKey {
        case id, name, username, email, phone, website, address
    }
}

struct AddressModel: Decodable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: GeoModel
    
    private enum CodingKeys: String, CodingKey {
        case street, suite, city, zipcode, geo
    }
}

struct GeoModel: Decodable {
    let lat: String
    let lng: String
    
    private enum CodingKeys: String, CodingKey {
        case lat, lng
    }
}

struct UserOperation: DecodableResponseOperation {
    
    typealias Model = UserModel
    typealias Response = Data
    
    var request: NetworkRequestProtocol
    
    init(userId: Int) {
        let headers: RequestHeadersCollection = [
            "Content-Type": "application/json; charset=UTF-8"
        ]
        
        request = Request(
            endpoint: "users/\(userId)",
            method: .get,
            headers: headers
        )
    }
}
