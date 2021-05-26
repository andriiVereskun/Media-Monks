//
//  CancellableRequest.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

import Foundation
import Alamofire

public protocol CancellableRequest {
    func cancelRequest()
}

extension DataRequest: CancellableRequest {
    public func cancelRequest() {
        _ = self.cancel()
    }
}
