//
//  SafeStorageProtocol.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

final class KeychainSafeStorage: SafeStorageProtocol {
    
    private let identifier: String
    private let accessGroup: String?
    
    /// Inits SafeStorage
    ///
    /// - Parameters:
    ///   - identifier: unique identifier that is used to group secure items
    ///   - accessGroup: identifier that is used for keychain group sharing
    init(identifier: String, accessGroup: String? = nil) {
        self.identifier = identifier
        self.accessGroup = accessGroup
    }
    
    func object<T: SafeStorageObjectRepresentable>(forKey key: String) -> Result<T, SafeStorageError> {
        var query = keychainQuery(key: key)
        query[kSecMatchLimit as String] = kSecMatchLimitOne   // search for one matching value, not all matching
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanTrue
        
        // Request data
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        // Check result
        guard status != errSecItemNotFound else {
            return .failure(.notInStorage)
        }
        guard status == noErr else {
            return .failure(.unknown(status))
        }
        
        // Parse data
        guard let existingItem = queryResult as? [String: AnyObject],
            let objectData = existingItem[kSecValueData as String] as? Data,
            let object = T(data: objectData)
            else
        {
            return .failure(.unexpectedObjectData)
        }
        
        return .success(object)
    }
    
    func set<T: SafeStorageObjectRepresentable>(_ object: T, forKey key: String) throws {
        guard let data = object.data else {
            throw SafeStorageError.unexpectedObjectData
        }
        
        var createEntry = false
        self.object(forKey: key)
            .ifSuccess { (_: T) in
                createEntry = false
            }
            .ifFailure { error in
                createEntry = (error == .notInStorage)
        }
        
        if createEntry {
            // Create new entry
            var newItem = keychainQuery(key: key)
            newItem[kSecValueData as String] = data as AnyObject?
            
            let status = SecItemAdd(newItem as CFDictionary, nil)
            if status != noErr {
                throw SafeStorageError.unknown(status)
            }
        } else {
            // Update with new data
            var attributesToUpdate = [String: AnyObject]()
            attributesToUpdate[kSecValueData as String] = data as AnyObject?
            
            let query = keychainQuery(key: key)
            let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
            if status != noErr {
                throw SafeStorageError.unknown(status)
            }
        }
    }
    
    func removeObject(forKey key: String) throws {
        let itemQuery = keychainQuery(key: key)
        let status = SecItemDelete(itemQuery as CFDictionary)
        if status != noErr {
            throw SafeStorageError.unknown(status)
        }
    }
    
    // MARK: - Private methods
    
    private func keychainQuery(key: String) -> [String: AnyObject] {
        var query = [String: AnyObject]()
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrService as String] = identifier as AnyObject?
        query[kSecAttrAccount as String] = key as AnyObject?
        
        if let accessGroup = accessGroup {
            query[kSecAttrAccessGroup as String] = accessGroup as AnyObject?
        }
        
        return query
    }
}
