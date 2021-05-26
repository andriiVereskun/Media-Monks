//
//  NetworkOperation.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

public protocol NetworkOperation: Operation where Response == NetworkResponseProtocol {}
