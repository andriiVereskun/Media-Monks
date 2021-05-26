//
//  PhotoListProtocol.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/25/21.
//

import Foundation

import Foundation

protocol PhotoListProtocol {
    func fetchPhotos(completion: @escaping (Result<[PhotoListModel], PhotoListServiceError>) -> Void)
    func fetchAlbum(albunId: Int, completion: @escaping (Result<AlbumModel, PhotoListServiceError>) -> Void)
    func fetchUser(userId: Int, completion: @escaping (Result<UserModel, PhotoListServiceError>) -> Void)
}
