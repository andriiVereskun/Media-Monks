//
//  UserSettingsStorage.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

final class UserSettingsStorage: UserSettingsStorageProtocol {
    
    private let userDefaults: UserDefaults
    
    init() {
        userDefaults = UserDefaults()
    }
    
    func value<T>(forKey key: String) -> T? {
        return userDefaults.value(forKey: key) as? T
    }
    
    func set<T>(value: T, forKey key: String) {
        userDefaults.setValue(value, forKey: key)
    }
    
    func synchronize() {
        CFPreferencesAppSynchronize(kCFPreferencesCurrentApplication)
    }
}

