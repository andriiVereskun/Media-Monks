//
//  PhotoListModuleConfigurator.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation
import Swinject

final class PhotoListModuleConfigurator {
    
    private enum Constants {
        static let storyboardName = "PhotoList"
    }
        
    private let diContainer: Container
    
    init(diContainer: Container) {
        self.diContainer = diContainer
    }
    
    func moduleViewAndInput(withOutput: PhotoListModuleOutput) -> (PhotoListViewController, PhotoListModuleInput) {
        let moduleView = moduleViewController()
        let moduleInput = moduleConfigured(for: moduleView, withOutput: withOutput)
        return (moduleView, moduleInput)
    }
    
    // MARK: - Private Methods
    
    private func moduleViewController() -> PhotoListViewController {
        let storyboard = UIStoryboard(name: Constants.storyboardName, bundle: Bundle.main)
        return storyboard.instantiate() as PhotoListViewController
    }
    
    private func moduleConfigured(for viewController: PhotoListViewController, withOutput: PhotoListModuleOutput) -> PhotoListModuleInput {
        let photoListService = diContainer.resolve(PhotoListProtocol.self)!
        let router = PhotoListRouter(diContainer: diContainer)
        router.viewController = viewController
        
        let presenter = PhotoListPresenter()
        let interactor = PhotoListInteractor(photoListProtocol: photoListService)
        viewController.output = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.output = withOutput
        interactor.output = presenter
                
        return presenter
    }
}
