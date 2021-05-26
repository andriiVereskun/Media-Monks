//
//  LoginInteractor.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

protocol LoginInteractorInput {
    var video: String { get }
}

protocol LoginInteractorOutput: AnyObject {}

final class LoginInteractor {
    
    // MARK: - Constants
    
    private enum Constants {
        static let video = "LoginVideo"
    }
    
    // MARK: - Public properties

    weak var output: LoginInteractorOutput!
    
    // MARK: - Private properties
    
    private (set) var video: String = Constants.video
}

// MARK: - LoginInteractorInput

extension LoginInteractor: LoginInteractorInput {}

