//
//  BaseNavigationController.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/25/21.
//

import UIKit

open class BaseNavigationController: UINavigationController {
    
    private var _statusBarStyle: UIStatusBarStyle?
    private var _shouldAutorotate: Bool?
    private var _supportedInterfaceOrientations: UIInterfaceOrientationMask?
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return _statusBarStyle ?? super.preferredStatusBarStyle
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return _supportedInterfaceOrientations ?? super.supportedInterfaceOrientations
    }
    
    override open var shouldAutorotate: Bool {
        return _shouldAutorotate ?? super.shouldAutorotate
    }
    
}

extension BaseNavigationController: StatusBarConfigurable {
    public func update(statusBarStyle style: UIStatusBarStyle) {
        _statusBarStyle = style
        setNeedsStatusBarAppearanceUpdate()
    }
}

extension BaseNavigationController: InterfaceOrientationConfigurable {
    func update(supportedInterfaceOrientation orientation: UIInterfaceOrientationMask) {
        _supportedInterfaceOrientations = orientation
        UIViewController.attemptRotationToDeviceOrientation()
    }
    
    func update(shouldAutorotate: Bool) {
        _shouldAutorotate = shouldAutorotate
    }
}

