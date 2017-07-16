//
//  LoginContext.swift
//  GalleryApp
//
//  Created by Bondar Pavel on 7/11/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit
import Alamofire

class LoginContext: AutentificationContext {
    
    override var reqestTail: String {
        return "/login"
    }
    
    override func fillMultipartFormData(_ multipartFormData: MultipartFormData) {
        self.email.data(using: String.Encoding.utf8).map { multipartFormData.append($0, withName: Constants.email) }
        self.password.data(using: String.Encoding.utf8).map { multipartFormData.append($0, withName: Constants.password) }
    }
}
