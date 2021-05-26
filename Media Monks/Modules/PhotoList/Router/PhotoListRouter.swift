//
//  PhotoListRouter.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation
import UIKit
import Swinject

protocol PhotoListRouterInput {
    func navigateToPhotoDetails(with userModel: UserModel)
}

protocol PhotoListRouterOutput: AnyObject {}

final class PhotoListRouter: PhotoListRouterInput {
    
    // MARK: - Public Properties
    
    weak var viewController: PhotoListViewController?
    weak var output: PhotoListRouterOutput!
    
    // MARK: - Private Properties
    
    private let diContainer: Container
    
    // MARK: - Lifecycle
    
    init(diContainer: Container) {
        self.diContainer = diContainer
    }
    
    func navigateToPhotoDetails(with userModel: UserModel) {
        let configurator = PhotoDetailModuleConfigurator(diContainer: diContainer)
        let (moduleView, moduleInptu) = configurator.moduleViewAndInput()
        moduleInptu.setupUserModel(userModel)
        viewController?.pushViewController(with: moduleView)
    }
}

