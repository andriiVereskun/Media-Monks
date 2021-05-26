//
//  UIViewController+Presentation.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/25/21.
//

import UIKit

extension UIViewController {
    var isPresentingForFirstTime: Bool {
        return isBeingPresented || isMovingToParent
    }
}

extension UIViewController {
    
    func returnToPhotoList(animated: Bool = true) {
        navigationController?.popToRootViewController(animated: animated)
    }
    
    func returnToPreviousController(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
    
    func pushViewController(with viewControllerToPush: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(viewControllerToPush, animated: animated)
    }
    
    func dismissPresentedController(animated: Bool = true) {
        dismiss(animated: animated)
    }
    
    func setBackBarButtonName(_ name: String) {
        guard let navigation = navigationController, navigation.viewControllers.count > 0 else { return }
        
        let backBarButton = UIBarButtonItem(title: name, style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        navigation.viewControllers.last?.navigationItem.backBarButtonItem = backBarButton
    }
    
    func setNavigationItemTitle(_ title: String) {
        navigationItem.title = title
    }
    
    func setupBackButtonItem() {
        let socialItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                                          style: .plain,
                                                          target: self,
                                                          action: #selector(backAction))
        socialItem.tintColor = .black
        navigationItem.leftBarButtonItems = [socialItem]
    }
    
    @objc private func backAction() {
        returnToPreviousController()
    }
    
    func setupCloseBarButtonItem() {
        let socialItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                                          style: .plain,
                                                          target: self,
                                                          action: #selector(closeAction))
        navigationItem.leftBarButtonItems = [socialItem]
    }
    
    @objc private func closeAction() {
        dismissPresentedController()
    }
    
    var isModal: Bool {

        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController

        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
}
