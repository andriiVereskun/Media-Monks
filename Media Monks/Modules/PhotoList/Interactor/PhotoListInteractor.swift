//
//  PhotoListInteractor.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

protocol PhotoListInteractorInput {
    var photos: [PhotoListModel] { get }
    func getPhotos()
    func getAlbum(with albumId: Int)
    func getUser(with userId: Int)
}

protocol PhotoListInteractorOutput: AnyObject {
    func didObtainPhotos(_ photos: [PhotoListModel])
    func didFailPhotos(_ error: PhotoListServiceError)
    func didObtainAlbum(_ album: AlbumModel)
    func didFailToObtainAlbum(_ error: PhotoListServiceError)
    func didObtainUser(_ user: UserModel)
    func didFailToObtainUser(_ error: PhotoListServiceError)
}

final class PhotoListInteractor {
    
    // MARK: - Public properties

    weak var output: PhotoListInteractorOutput!
    
    // MARK: - Private properties
    
    private let photoListService: PhotoListProtocol
    private (set) var photos: [PhotoListModel] = []
    
    init(photoListProtocol: PhotoListProtocol) {
        self.photoListService = photoListProtocol
    }
}

// MARK: - PhotoListInteractorInput

extension PhotoListInteractor: PhotoListInteractorInput {
    func getPhotos() {
        photoListService.fetchPhotos { result in
            result.ifSuccess { [weak self] model in
                guard let self = self else { return }
                self.photos = model
                self.output.didObtainPhotos(self.photos)
            }
            result.ifFailure { [weak self] error in
                guard let self = self else { return }
                self.output.didFailPhotos(error)
            }
        }
    }
    
    func getAlbum(with albumId: Int) {
        photoListService.fetchAlbum(albunId: albumId) { result in
            result.ifSuccess { [weak self] model in
                guard let self = self else { return }
                self.output.didObtainAlbum(model)
            }
            result.ifFailure { [weak self] error in
                guard let self = self else { return }
                self.output.didFailToObtainAlbum(error)
            }
        }
    }
    
    func getUser(with userId: Int) {
        photoListService.fetchUser(userId: userId) {result in
            result.ifSuccess { [weak self] model in
                guard let self = self else { return }
                self.output.didObtainUser(model)
            }
            result.ifFailure { [weak self] error in
                guard let self = self else { return }
                self.output.didFailToObtainUser(error)
            }
        }
    }
}

