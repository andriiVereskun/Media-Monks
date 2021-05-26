//
//  UIView+Round.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/25/21.
//

import UIKit

extension UIView {
    
    func round(corners: UIRectCorner = .allCorners, radius: CGFloat) {
        var maskedCorners = CACornerMask()
        
        if corners.contains(.topLeft) { maskedCorners.insert(.layerMinXMinYCorner) }
        if corners.contains(.topRight) { maskedCorners.insert(.layerMaxXMinYCorner) }
        if corners.contains(.bottomLeft) { maskedCorners.insert(.layerMinXMaxYCorner) }
        if corners.contains(.bottomRight) { maskedCorners.insert(.layerMaxXMaxYCorner) }
        
        layer.cornerRadius = radius
        layer.maskedCorners = maskedCorners
    }
    
    func round(corners: UIRectCorner = .allCorners) {
        round(corners: corners, radius: min(frame.width, frame.height) / 2)
    }
}
