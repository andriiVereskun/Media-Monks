//
//  PhotoDetailModuleInterface.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

protocol PhotoDetailModuleInput: AnyObject {
    func setupUserModel(_ model: UserModel)
}

protocol PhotoDetailModuleOutput: AnyObject {}
