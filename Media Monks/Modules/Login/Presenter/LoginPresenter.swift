//
//  LoginPresenter.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

final class LoginPresenter {
    
    // MARK: - Public properties
    
    weak var view: LoginViewInput!
    var interactor: LoginInteractorInput!
    var router: LoginRouterInput!
    weak var output: LoginModuleOutput?
}

// MARK: - LoginModuleInput

extension LoginPresenter: LoginModuleInput {}

// MARK: - LoginViewOutput

extension LoginPresenter: LoginViewOutput {
    func viewIsReady() {
        view.setState(.initialState(interactor.video))
    }
    
    func didTapLoginButton() {
        output?.navigateToPhotoList()
    }
    
    func didTapLoginWithOutLoginAndPassword() {
        output?.navigateToPhotoList()
    }
}

// MARK: - LoginInteractorOutput

extension LoginPresenter: LoginInteractorOutput {}

// MARK: - LoginRouterOutput

extension LoginPresenter: LoginRouterOutput {}

