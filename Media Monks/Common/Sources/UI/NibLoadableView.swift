//
//  NibLoadableView.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import UIKit

public protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static public var nibName: String {
        return String(describing: self)
    }
}
