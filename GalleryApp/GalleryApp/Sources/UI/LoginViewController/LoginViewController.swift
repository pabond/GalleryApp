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
        if let email = emailValidation(), let password = passwordValidation(), let wSelf = weakSelf(self) {
            let loginContext = LoginContext(success: wSelf.loginSuccess,
                                            fail: wSelf.loginFailed,
                                            user: User(),
                                            password: password,
                                            email: email)
            
            loginContext.execute()
        }
    }
    
    @IBAction func onAvatar(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true)
        }
    }
    
    private func loginSuccess(_ user : User) {
        let galleryController = GalleryViewController.viewController()
        let navController = UINavigationController(rootViewController: galleryController)
        present(navController, animated: true)
    }
    
    private func loginFailed() {
        if let email = emailValidation(), let password = passwordValidation(), let image = avatarValidateion() {
            let signUpContext = SignUpContext(success: loginSuccess,
                                              fail: singUpFailed,
                                              user: User(),
                                              password: password,
                                              email: email,
                                              avatar: image,
                                              userName: rootView?.userNameTextField.text)
            signUpContext.execute()
        }
    }
    
    private func singUpFailed() {
        infoAlert(title: "Failed", text: "Please check your internet connection")
    }
        
    private func avatarValidateion() -> UIImage? {
        let avatar = rootView?.avatarImageView.image.flatMap { $0 != #imageLiteral(resourceName: "DefaultAvatar") ? $0 : nil }
        if avatar == nil {
            self.infoAlert(title: "Avatar not set", text: "Please set your avatar")
        }
        
        return avatar
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

extension LoginViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        info[UIImagePickerControllerOriginalImage]
            .flatMap { $0 as? UIImage }
            .map { self.rootView?.avatarImageView.image = $0 }
        picker.dismiss(animated: true)
    }
}
