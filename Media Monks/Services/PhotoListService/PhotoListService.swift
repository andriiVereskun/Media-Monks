//
//  PhotoListService.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/25/21.
//

import Foundation

enum PhotoListServiceError: Error, Equatable {
    
    case networkError(NetworkError)
    
    static func == (lhs: PhotoListServiceError, rhs: PhotoListServiceError) -> Bool {
        switch (lhs, rhs) {
        case (.networkError(let lhsError), .networkError(let rhsError)):
            return lhsError %= rhsError
        }
    }
}

final class PhotoListService: PhotoListProtocol {

    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    // MARK: - Public methods
    
    func fetchPhotos(completion: @escaping (Result<[PhotoListModel], PhotoListServiceError>) -> Void) {
        let operation = PhotoListOperation()
        networkService.execute(operation) { result in
            result.ifSuccess {
                completion(.success($0))
            }
            result.ifFailure {
                completion(.failure(.networkError($0)))
            }
        }
    }
    
    func fetchAlbum(albunId: Int, completion: @escaping (Result<AlbumModel, PhotoListServiceError>) -> Void) {
        let operation = GetAlbumOperation(albumId: albunId)
        networkService.execute(operation) { result in
            result.ifSuccess {
                completion(.success($0))
            }
            result.ifFailure {
                completion(.failure(.networkError($0)))
            }
        }
    }
    
    func fetchUser(userId: Int, completion: @escaping (Result<UserModel, PhotoListServiceError>) -> Void) {
        let operation = UserOperation(userId: userId)
        networkService.execute(operation) { result in
            result.ifSuccess {
                completion(.success($0))
            }
            result.ifFailure {
                completion(.failure(.networkError($0)))
            }
        }
    }
}

