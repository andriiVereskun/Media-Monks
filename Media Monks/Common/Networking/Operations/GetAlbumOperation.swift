//
//  GetAlbumOperation.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/26/21.
//

import Foundation
import Alamofire

struct AlbumModel: Decodable {
    
    let userId: Int
    let id: Int
    let title: String
    
    private enum CodingKeys: String, CodingKey {
        case userId, id, title
    }
}

struct GetAlbumOperation: DecodableResponseOperation {
    
    typealias Model = AlbumModel
    typealias Response = Data
    
    var request: NetworkRequestProtocol
    
    init(albumId: Int) {
        let headers: RequestHeadersCollection = [
            "Content-Type": "application/json; charset=UTF-8"
        ]
        
        request = Request(
            endpoint: "albums/\(albumId)",
            method: .get,
            headers: headers
        )
    }
}
