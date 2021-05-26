//
//  PhotoDetailPresenter.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

final class PhotoDetailPresenter {
    
    // MARK: - Public properties
    
    weak var view: PhotoDetailViewInput!
    var interactor: PhotoDetailInteractorInput!
    var router: PhotoDetailRouterInput!
    weak var output: PhotoDetailModuleOutput?
}

// MARK: - PhotoDetailModuleInput

extension PhotoDetailPresenter: PhotoDetailModuleInput {
    func setupUserModel(_ model: UserModel) {
        interactor.setUser(model)
    }
}

// MARK: - PhotoDetailViewOutput

extension PhotoDetailPresenter: PhotoDetailViewOutput {
    func viewIsReady() {
        guard let model = interactor.user else { return }
        view.setState(.initialState(setupViewModel(model)))
    }
}

// MARK: - PhotoListInteractorOutput

extension PhotoDetailPresenter: PhotoDetailInteractorOutput {}

// MARK: - PhotoListRouterOutput

extension PhotoDetailPresenter: PhotoDetailRouterOutput {}

// MARK: - Private methods

private extension PhotoDetailPresenter {
    func setupViewModel(_ model: UserModel) -> PhotoDetailViewController.ViewModel {
        .init(fullName: model.name,
              userName: model.username,
              email: model.email,
              phone: model.phone,
              website: model.website,
              city: model.address.city,
              street: model.address.street,
              lat: Double(model.address.geo.lat) ?? 0,
              lng: Double(model.address.geo.lng) ?? 0)
    }
}
