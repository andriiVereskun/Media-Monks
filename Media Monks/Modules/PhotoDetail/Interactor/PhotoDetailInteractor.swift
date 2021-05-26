//
//  PhotoDetailInteractor.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

protocol PhotoDetailInteractorInput {
    func setUser(_ userModel: UserModel)
    var user: UserModel? { get }
}

protocol PhotoDetailInteractorOutput: AnyObject {}

final class PhotoDetailInteractor {

    // MARK: - Public properties
    
    weak var output: PhotoDetailInteractorOutput!
    
    // MARK: - Private properties
    
    private (set) var user: UserModel?
}

// MARK: - PhotoDetailInteractorInput

extension PhotoDetailInteractor: PhotoDetailInteractorInput {
    
    func setUser(_ userModel: UserModel) {
        user = userModel
    }
}
