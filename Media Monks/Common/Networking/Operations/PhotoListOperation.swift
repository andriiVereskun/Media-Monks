//
//  PhotoListOperation.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/25/21.
//

import Foundation
import Alamofire

struct PhotoListModel: Decodable {
    
    let albumId: Int
    let id: Int
    let title: String
    let url: URL
    let thumbnailUrl: URL
    
    private enum CodingKeys: String, CodingKey {
        case albumId, id, title, url, thumbnailUrl
    }
}

struct PhotoListOperation: DecodableResponseOperation {
    
    typealias Model = [PhotoListModel]
    typealias Response = Data
    
    var request: NetworkRequestProtocol
    
    init() {
        let headers: RequestHeadersCollection = [
            "Content-Type": "application/json; charset=UTF-8"
        ]
        
        request = Request(
            endpoint: "photos",
            method: .get,
            headers: headers
        )
    }
}
