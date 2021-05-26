//
//  RequestMethod+Alamofire.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Alamofire

extension RequestMethod {
    var alamofireMethod: HTTPMethod {
        switch self {
        case .options: return .options
        case .get: return .get
        case .head: return .head
        case .post: return .post
        case .put: return .put
        case .patch: return .patch
        case .delete: return .delete
        case .trace: return .trace
        case .connect: return .connect
        }
    }
}
