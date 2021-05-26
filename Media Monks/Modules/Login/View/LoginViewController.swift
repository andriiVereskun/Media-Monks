//
//  LoginViewController.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/14/21.
//

import UIKit
import SwiftVideoBackground

protocol LoginViewInput: AnyObject {
    func setState(_ state: LoginViewController.State)
}

protocol LoginViewOutput {
    func viewIsReady()
    func didTapLoginButton()
    func didTapLoginWithOutLoginAndPassword()
}

final class LoginViewController: BaseViewController, Instantiatable, LoginViewInput {
    
    // MARK: - View state
    
    enum State {
        case initialState(String)
        
        func apply(on view: LoginViewController) {
            switch self {
            case .initialState(let video):
                view.viewIsReady(with: video)
            }
        }
    }
    
    // MARK: - Public properties
    
    var output: LoginViewOutput!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    deinit {
        print(Self.self)
    }
    
    // MARK: - CreateNewPostViewInput
    
    func setState(_ state: State) {
        state.apply(on: self)
    }
}

// MARK: - Actions

private extension LoginViewController {
    @IBAction func loginAction(_ sender: UIButton) {
        output.didTapLoginButton()
    }
    
    @IBAction func loginWithoutLoginAndPasswordAction(_ sender: UIButton) {
        output.didTapLoginWithOutLoginAndPassword()
    }
}

// MARK: - Private Methods

private extension LoginViewController {
    func viewIsReady(with video: String) {
        setUpVideoBackground(with: video)
    }
    
    func setUpVideoBackground(with video: String) {
        try? VideoBackground.shared.play(
            view: view,
            videoName: video,
            videoType: "mp4",
            isMuted: true,
            darkness: 0.5,
            willLoopVideo: true,
            setAudioSessionAmbient: true
        )
    }
}

