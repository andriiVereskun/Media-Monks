//
//  Image.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/25/21.
//

import Foundation
import UIKit

enum BaseImage: Hashable {
    case image(UIImage?)
    case stringUrl(String?)
    
    var imageValue: UIImage? {
        switch self {
        case .image(let value):
            return value
        case .stringUrl:
            return nil
        }
    }
    
    var stringUrlValue: String? {
        switch self {
        case .image:
            return nil
        case .stringUrl(let value):
            return value
        }
    }
}

extension UIImageView {
    
    func render(_ image: BaseImage, placeholder: UIImage? = nil) {
        switch image {
        case .image(let value):
            self.image = value
        case .stringUrl(let value):
            self.setImage(with: value, placeholder: placeholder)
        }
    }
}
