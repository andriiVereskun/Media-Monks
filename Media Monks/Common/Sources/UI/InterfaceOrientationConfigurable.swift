//
//  InterfaceOrientationConfigurable.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import UIKit

protocol InterfaceOrientationConfigurable {
    func update(supportedInterfaceOrientation orientation: UIInterfaceOrientationMask)
    func update(shouldAutorotate: Bool)
}
