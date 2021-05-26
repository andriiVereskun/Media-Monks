//
//  ServerAPIConfiguration.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/25/21.
//

import Foundation

/// Configuration structure describing API endpoint used to communicate with server side
struct ServerAPIConfiguration {
    
    private enum Constants {
        static let configurationList = "ServerAPIConfigurationList"
    }
    
    enum Error: Swift.Error {
        case configurationNotFound
    }
    
    /// Configuration name as in Info.plist
    let name: String
    /// Host converted from string from Info.plist
    let host: URL
    
    /// Returns available configurations from Info.plist
    ///
    /// - Throws: ServerAPIConfiguration.Error if configs not found
    static func availableConfigurations() throws -> [ServerAPIConfiguration] {
        guard let plist = PlistReader.create(name: Constants.configurationList),
            let configurationList = plist.data as? [AnyHashable: Any],
            let servers = configurationList["pr-available-servers"] as? [String: Any]
            else {
                throw Error.configurationNotFound
        }
        
        return try servers.map { item in
            let (key, value) = item
            let config = (value as? String)
                .flatMap { URL(string: $0) }
                .flatMap { ServerAPIConfiguration(name: key, host: $0) }
            
            if let resultConfig = config {
                return resultConfig
            } else {
                throw Error.configurationNotFound
            }
        }
    }
    
    /// Returns default configuration from Info.plist
    ///
    /// - Throws: ServerAPIConfiguration.Error
    static func defaultConfiguration() throws -> ServerAPIConfiguration {
        let configs = try availableConfigurations()
        let defaultName = try defaultConfigurationName()
        if let config = configs.first(where: { $0.name == defaultName }) {
            return config
        } else {
            throw Error.configurationNotFound
        }
    }
    
    /// Returns default configuration index from Info.plist, relates to array returned by `availableConfiguations()`
    ///
    /// - Throws: ServerAPIConfiguration.Error
    static func defaultConfigurationName() throws -> String {
        guard let plist = PlistReader.create(name: Constants.configurationList),
            let configurationList = plist.data as? [AnyHashable: Any],
            let defaultServerName = configurationList["pr-default-server"] as? String
        else {
            throw Error.configurationNotFound
        }
        
        return defaultServerName
    }
    
}

