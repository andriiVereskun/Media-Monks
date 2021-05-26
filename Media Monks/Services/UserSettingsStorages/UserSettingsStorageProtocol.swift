//
//  UserSettingsStorageProtocol.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

protocol UserSettingsStorageProtocol {
    func value<T>(forKey key: String) -> T?
    func set<T>(value: T, forKey key: String)
    func synchronize()
}
