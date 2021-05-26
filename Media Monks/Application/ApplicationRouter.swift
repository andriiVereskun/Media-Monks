//
//  ApplicationRouter.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Swinject

final class ApplicationRouter {
    
    private enum Constants {
        static let isAuthorization = "isAuthorization"
    }
    
    enum RoutingSection {
        case authorization
        case photoList
    }
    
    private var window: UIWindow
    private let diContainer: Container
    private let userSettingsStorage: UserSettingsStorageProtocol
    private var isAuthorization: Bool {
        return userSettingsStorage.value(forKey: Constants.isAuthorization) ?? false
    }
    
    private var routingSection: RoutingSection {
        return isAuthorization ? .photoList : .authorization
    }
    
    init(window: UIWindow, diContainer: Container) {
        self.window = window
        self.diContainer = diContainer
        self.userSettingsStorage = diContainer.resolve(UserSettingsStorageProtocol.self)!
    }
    
    func presentStartupScreen() {
        if routingSection == .photoList {
            presentPhotoListModule()
        } else {
            presentAuthorizationModule()
        }
    }
    
    func presentAuthorizationModule() {
        let configurator = LoginModuleConfigurator(diContainer: diContainer)
        let (moduleView, _) = configurator.moduleViewAndInput(withOutput: self)
        window.rootViewController = moduleView
    }
    
    // MARK: - Private methods
    
    private func presentPhotoListModule() {
        let configurator = PhotoListModuleConfigurator(diContainer: diContainer)
        let (moduleView, _) = configurator.moduleViewAndInput(withOutput: self)
        let navigationController = BaseNavigationController(rootViewController: moduleView)
        window.rootViewController = navigationController
    }
}

// MARK: - PhotoListModuleOutput

extension ApplicationRouter: PhotoListModuleOutput {
    func userLogoutRequested() {
        presentAuthorizationModule()
        userSettingsStorage.set(value: false, forKey: Constants.isAuthorization)
    }
}

// MARK: - LoginModuleOutput

extension ApplicationRouter: LoginModuleOutput {
    func navigateToPhotoList() {
        presentPhotoListModule()
        userSettingsStorage.set(value: true, forKey: Constants.isAuthorization)
    }
}
