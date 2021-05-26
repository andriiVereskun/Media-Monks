//
//  KeychainSafeStorage.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

protocol SafeStorageObjectRepresentable {
    
    var data: Data? { get }
    init?(data: Data)
    
}

protocol SafeStorageProtocol {
    
    func object<T: SafeStorageObjectRepresentable>(forKey key: String) -> Result<T, SafeStorageError>
    func set<T: SafeStorageObjectRepresentable>(_ object: T, forKey key: String) throws
    func removeObject(forKey key: String) throws
}

enum SafeStorageError: Swift.Error, Equatable {
    case notInStorage
    case unexpectedObjectData
    case unknown(OSStatus)
    
    public static func == (lhs: SafeStorageError, rhs: SafeStorageError) -> Bool {
        switch (lhs, rhs) {
        case (.notInStorage, .notInStorage): return true
        case (.unexpectedObjectData, .unexpectedObjectData): return true
        case (.unknown(let statusLeft), .unknown(let statusRight)): return statusLeft == statusRight
        default:
            return false
        }
    }
}
