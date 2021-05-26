//
//  ServerAPIEndpointStorage.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/25/21.
//

import Foundation

protocol ServerAPIEndpointStorageProtocol {
    
    var apiServerHostURL: URL { get }
    var apiServerURL: URL { get }
    func updateServerHost(to serverHost: URL)
}


class ServerAPIEndpointStorage: ServerAPIEndpointStorageProtocol {
    
    private enum Constants {
        static let serverAPIHostKey = "PRCurrentServerHost"
    }
    
    private typealias ConfigParameters = [AnyHashable: Any]
    
    // MARK: - Public properties
    
    private (set) lazy var apiServerHostURL: URL = {
        return apiServerHostURLFromStoredSettings ?? apiServerHostURLFromConfiguration
    }()
    
    private (set) lazy var apiServerURL: URL = {
        return apiServerHostURL.appendingPathComponent(apiPath)
    }()
    
    private lazy var plistReaderInfo: Any? = {
        guard let plistReader = PlistReader.create(name: "ServerAPIConfigurationList") else {
            return [:]
        }
        return plistReader.data
    }()
    
    private lazy var apiPath: String = {
        guard let readerInfo = plistReaderInfo as? ConfigParameters,
            let apiPath = readerInfo["pr-api-path"] as? String else {
                return ""
        }
        return apiPath
    }()
    
    // MARK: - Private properties
    
    private let settingsStorage: UserSettingsStorageProtocol
    
    private var apiServerHostURLFromConfiguration: URL {
        do {
            let config = try ServerAPIConfiguration.defaultConfiguration()
            return config.host
        }
        catch {
            fatalError("Unable to retrieve API configuration, make sure it is set in Info.plist. Error: \(error)")
        }
    }
    
    private var apiServerHostURLFromStoredSettings: URL? {
        return (settingsStorage.value(forKey: Constants.serverAPIHostKey) as String?)
            .flatMap { return URL(string: $0) }
    }
    
    // MARK: - Lifecycle
    
    init(settingsStorage: UserSettingsStorageProtocol) {
        self.settingsStorage = settingsStorage
    }
    
    // MARK: - Public Methods
    
    func updateServerHost(to serverHost: URL) {
        settingsStorage.set(value: serverHost.absoluteString, forKey: Constants.serverAPIHostKey)
        settingsStorage.synchronize()
    }
}
