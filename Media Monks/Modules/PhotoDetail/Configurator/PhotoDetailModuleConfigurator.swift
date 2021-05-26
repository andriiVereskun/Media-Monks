//
//  PhotoDetailModuleConfigurator.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/25/21.
//

import Foundation
import Swinject

final class PhotoDetailModuleConfigurator {
    
    private enum Constants {
        static let storyboardName = "PhotoDetail"
    }
        
    private let diContainer: Container
    
    init(diContainer: Container) {
        self.diContainer = diContainer
    }
    
    func moduleViewAndInput() -> (PhotoDetailViewController, PhotoDetailModuleInput) {
        let moduleView = moduleViewController()
        let moduleInput = moduleConfigured(for: moduleView)
        return (moduleView, moduleInput)
    }
    
    // MARK: - Private Methods
    
    private func moduleViewController() -> PhotoDetailViewController {
        let storyboard = UIStoryboard(name: Constants.storyboardName, bundle: Bundle.main)
        return storyboard.instantiate() as PhotoDetailViewController
    }
    
    private func moduleConfigured(for viewController: PhotoDetailViewController) -> PhotoDetailModuleInput {
        let router = PhotoDetailRouter(diContainer: diContainer)
        router.viewController = viewController
        
        let presenter = PhotoDetailPresenter()
        let interactor = PhotoDetailInteractor()
        
        viewController.output = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
                
        return presenter
    }
}
