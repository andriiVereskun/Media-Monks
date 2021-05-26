//
//  LoginRouter.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation
import UIKit
import Swinject

protocol LoginRouterInput {
    
}

protocol LoginRouterOutput: AnyObject {}

final class LoginRouter: LoginRouterInput {
    
    // MARK: - Public Properties
    
    weak var viewController: LoginViewController?
    weak var output: LoginRouterOutput!
    
    // MARK: - Private Properties
    
    private let diContainer: Container
    
    // MARK: - Lifecycle
    
    init(diContainer: Container) {
        self.diContainer = diContainer
    }
}



