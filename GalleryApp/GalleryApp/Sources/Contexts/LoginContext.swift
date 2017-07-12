//
//  LoginContext.swift
//  GalleryApp
//
//  Created by Bondar Pavel on 7/11/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit

class LoginContext: AutentificationContext {
    
    override var reqestTail: String {
        return "/login"
    }
    
    override var headers : [String : String] {
        return [Constants.email : self.email, Constants.password : self.password]
    }
}
