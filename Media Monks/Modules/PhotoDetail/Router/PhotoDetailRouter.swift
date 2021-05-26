//
//  PhotoDetailRouter.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

import Foundation
import UIKit
import Swinject

protocol PhotoDetailRouterInput {}

protocol PhotoDetailRouterOutput: AnyObject {}

final class PhotoDetailRouter: PhotoDetailRouterInput {
    
    // MARK: - Public Properties
    
    weak var viewController: PhotoDetailViewController?
    weak var output: PhotoDetailRouterOutput!
    
    // MARK: - Private Properties
    
    private let diContainer: Container
    
    // MARK: - Lifecycle
    
    init(diContainer: Container) {
        self.diContainer = diContainer
    }
}


