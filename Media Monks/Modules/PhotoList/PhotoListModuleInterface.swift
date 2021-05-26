//
//  PhotoListModuleInterface.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

protocol PhotoListModuleInput: AnyObject {}

protocol PhotoListModuleOutput: AnyObject {
    func userLogoutRequested()
}
