//
//  LoginModuleInterface.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

protocol LoginModuleInput: AnyObject {}

protocol LoginModuleOutput: AnyObject {
    func navigateToPhotoList()
}
