//
//  UINavigationBar+Extensions.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/25/21.
//


import UIKit

extension UINavigationBar {
    func hideShadow(_ value: Bool = true) {
        setValue(value, forKey: "hidesShadow")
    }
}
