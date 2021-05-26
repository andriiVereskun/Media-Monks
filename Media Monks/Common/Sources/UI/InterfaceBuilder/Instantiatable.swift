//
//  Instantiatable.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

public protocol Instantiatable: AnyObject {
    static var identifier: String { get }
}

extension Instantiatable {
    public static var identifier: String {
        return String(describing: self)
    }
}
