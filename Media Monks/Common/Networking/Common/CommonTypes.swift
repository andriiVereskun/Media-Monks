//
//  CommonTypes.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

public typealias ResponseStatusCode = Int
public typealias JSON = [String: Any?]

public typealias RequestHeadersCollection = [String: String]
public typealias RequestHeader = RequestHeadersCollection.Element

public typealias RequestParametersCollection = [String: Any]
public typealias RequestParameter = RequestParametersCollection.Element

public typealias Mapping<Input, Output> = (Input) throws -> Output
