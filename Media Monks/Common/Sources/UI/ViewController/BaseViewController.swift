//
//  BaseViewController.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import UIKit

open class BaseViewController: UIViewController {
    
    private var _statusBarStyle: UIStatusBarStyle?
    private var _shouldHideStatusBar: Bool?
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
    
    override open var prefersStatusBarHidden: Bool {
        return _shouldHideStatusBar ?? super.prefersStatusBarHidden
    }
    
}

extension BaseViewController: StatusBarConfigurable {
    
    public func update(statusBarStyle style: UIStatusBarStyle) {
        _statusBarStyle = style
        setNeedsStatusBarAppearanceUpdate()
    }
    
    public func update(shouldHideStatusBar: Bool) {
        _shouldHideStatusBar = shouldHideStatusBar
        setNeedsStatusBarAppearanceUpdate()
    }
}

extension BaseViewController: InterfaceOrientationConfigurable {
    
    public func update(supportedInterfaceOrientation orientation: UIInterfaceOrientationMask) {
        _supportedInterfaceOrientations = orientation
        UIViewController.attemptRotationToDeviceOrientation()
    }
    
    public func update(shouldAutorotate: Bool) {
        _shouldAutorotate = shouldAutorotate
    }
}
