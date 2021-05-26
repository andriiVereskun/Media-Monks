//
//  ApplicationDIContainer.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Swinject

class ApplicationDIContainer {
    
    let container = Container()
    
    init() {
        registerServices()
        registerNetworking()
    }
}

private extension ApplicationDIContainer {
    func registerServices() {
        container.register(SafeStorageProtocol.self) { resolver in
            let appConfig = resolver.resolve(ApplicationConfiguration.self)!
            return KeychainSafeStorage(identifier: appConfig.applicationKeychainSafeStorageServiceKey)
        }.inObjectScope(.container)
        
        container.register(UserSettingsStorageProtocol.self) { _ in
            return UserSettingsStorage()
        }.inObjectScope(.container)
        
        container.register(ServerAPIEndpointStorageProtocol.self) { resolver in
            let settingsStorage = resolver.resolve(UserSettingsStorageProtocol.self)!
            return ServerAPIEndpointStorage(settingsStorage: settingsStorage)
        }.inObjectScope(.container)
    }
    
    func registerNetworking() {
        container.register(NetworkServiceProtocol.self) { resolver in
            let endpointStorage = resolver.resolve(ServerAPIEndpointStorageProtocol.self)!
            let config = NetworkService.Configuration(baseURL: endpointStorage.apiServerURL, headers: [:])
            return NetworkService(configuration: config, dispatcher: AlamofireRequestDispatcher())
        }.inObjectScope(.container)
        
        container.register(PhotoListProtocol.self) { resolver in
            let networkService = resolver.resolve(NetworkServiceProtocol.self)!
            return PhotoListService(networkService: networkService)
        }.inObjectScope(.container)
    }
}
