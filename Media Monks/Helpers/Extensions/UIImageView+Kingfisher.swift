//
//  UIImageView+Kingfisher.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/25/21.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    enum ImageViewLoadingEror: Error {
        case emptyURLString
    }
    
    func setImage(with urlString: String?,
                  placeholder: Placeholder? = nil,
                  completionHandler: ((Result<UIImage, Error>) -> Void)? = nil) {
        
        guard let urlString = urlString else {
            completionHandler?(.failure(ImageViewLoadingEror.emptyURLString))
            return
        }
        
        kf.setImage(with: URL(string: urlString), placeholder: placeholder, completionHandler:  { result in
            switch result {
            case .success(let value):
                completionHandler?(.success(value.image))
            case .failure(let error):
                completionHandler?(.failure(error))
            }
        })
    }
    
    func cancelLoading() {
        kf.cancelDownloadTask()
    }
}
