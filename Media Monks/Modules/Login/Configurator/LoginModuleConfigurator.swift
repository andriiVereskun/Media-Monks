//
//  LoginModuleConfigurator.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation
import Swinject

final class LoginModuleConfigurator {
    
    private enum Constants {
        static let storyboardName = "Main"
    }
        
    private let diContainer: Container
    
    
    init(diContainer: Container) {
        self.diContainer = diContainer
    }
    
    func moduleViewAndInput(withOutput: LoginModuleOutput) -> (LoginViewController, LoginModuleInput) {
        let moduleView = moduleViewController()
        let moduleInput = moduleConfigured(for: moduleView, withOutput: withOutput)
        return (moduleView, moduleInput)
    }
    
    // MARK: - Private Methods
    
    private func moduleViewController() -> LoginViewController {
        let storyboard = UIStoryboard(name: Constants.storyboardName, bundle: Bundle.main)
        return storyboard.instantiate() as LoginViewController
    }
    
    private func moduleConfigured(for viewController: LoginViewController, withOutput: LoginModuleOutput) -> LoginModuleInput {
        let router = LoginRouter(diContainer: diContainer)
        router.viewController = viewController
        
        let presenter = LoginPresenter()
        let interactor = LoginInteractor()
        
        viewController.output = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.output = withOutput
                
        return presenter
    }
}
