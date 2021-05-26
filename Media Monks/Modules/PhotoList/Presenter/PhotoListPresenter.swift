//
//  PhotoListPresenter.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

final class PhotoListPresenter {
    
    // MARK: - Public properties
    
    weak var view: PhotoListViewInput!
    var interactor: PhotoListInteractorInput!
    var router: PhotoListRouterInput!
    weak var output: PhotoListModuleOutput?
}

// MARK: - PhotoListModuleInput

extension PhotoListPresenter: PhotoListModuleInput {}

// MARK: - PhotoListViewOutput

extension PhotoListPresenter: PhotoListViewOutput {
    func viewIsReady() {
        view.setState(.viewIsReady)
        view.setState(.isLoading)
        interactor.getPhotos()
    }
    
    func didTapLogout() {
        output?.userLogoutRequested()
    }
}

// MARK: - PhotoListInteractorOutput

extension PhotoListPresenter: PhotoListInteractorOutput {
    func didObtainAlbum(_ album: AlbumModel) {
        interactor.getUser(with: album.userId)
    }
    
    func didFailToObtainAlbum(_ error: PhotoListServiceError) {
        /// Here we can show error message for user on ui layer
        view.setState(.dataIsLoaded)
        print(#function)
        print("Handle error - \(error.localizedDescription)")
    }
    
    func didObtainUser(_ user: UserModel) {
        view.setState(.dataIsLoaded)
        router.navigateToPhotoDetails(with: user)
    }
    
    func didFailToObtainUser(_ error: PhotoListServiceError) {
        /// Here we can show error message for user on ui layer
        view.setState(.dataIsLoaded)
        print(#function)
        print("Handle error - \(error.localizedDescription)")
    }
    
    func didObtainPhotos(_ photos: [PhotoListModel]) {
        view.setState(.dataIsLoaded)
        view.setState(.updateContent(setupViewModel(photos)))
    }
    
    func didFailPhotos(_ error: PhotoListServiceError) {
        /// Here we can show error message for user on ui layer
        view.setState(.dataIsLoaded)
        print(#function)
        print("Handle error - \(error.localizedDescription)")
    }
}

// MARK: - PhotoListRouterOutput

extension PhotoListPresenter: LoginRouterOutput {}

// MARK: - Private methods

private extension PhotoListPresenter {
    func setupViewModel(_ photoModels: [PhotoListModel]) -> [PhotoCollectionViewCell.ViewModel] {
        print(photoModels)
        var viewModels = [PhotoCollectionViewCell.ViewModel]()
        photoModels.forEach { photoModel in
            let viewModel = PhotoCollectionViewCell.ViewModel(title: photoModel.title,
                                                              url: photoModel.url,
                                                              tapAction: tapAction(photoModel.albumId))
            viewModels.append(viewModel)
        }
        return viewModels
    }
}

// MARK: - Actions

private extension PhotoListPresenter {
    func tapAction(_ albumId: Int) -> Command {
        .init { [unowned self] in
            self.view.setState(.isLoading)
            self.interactor.getAlbum(with: albumId)
        }
    }
}

