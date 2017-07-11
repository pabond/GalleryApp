//
//  LoginViewController.swift
//  GalleryApp
//
//  Created by Bondar Pavel on 7/11/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, RootViewGettable, Weakable {
    
    typealias RootViewType = LoginView
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func onSend(_ sender: Any) {
        if let email = emailValidation(), let password = passwordValidation() {
            let loginContext = LoginContext()
            
            let wSelf = weakSelf(self)
            loginContext.execute(email: email,
                                 password: password,
                                 success: {
                             wSelf?.loginSuccess()
            }, fail: {
                wSelf?.loginFailed()
            })
        }
    }
    
    @IBAction func onAvatar(_ sender: Any) {
        
    }
    
    private func loginSuccess() {
        
    }
    
    private func loginFailed() {
    
    }
    
    private func emailValidation() -> String? {
        let email = rootView?.emailTextField.text.flatMap { Email.isValid(email: $0) ? $0 : nil }
        if email == nil {
            self.infoAlert(title: "Email invalid", text: "Please enter valid email")
        }
        
        return email
    }
    
    private func passwordValidation() -> String? {
        let password = rootView?.passwordTextField.text.flatMap { $0.isEmpty ? nil : $0 }
        if password == nil {
            self.infoAlert(title: "Password invalid", text: "Password not added")
        }
        
        return password
    }
}
