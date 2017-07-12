//
//  SignUpContext.swift
//  GalleryApp
//
//  Created by Bondar Pavel on 7/11/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit

class SignUpContext: AutentificationContext {
    
    override var reqestTail: String {
        return "/create"
    }
    
    override var headers : [String : String] {
        var header = [Constants.email : self.email,
                      Constants.password : self.password,
                      Constants.username : self.userName ?? ""]
        
        _ = self.avatar?.base64.map { header.updateValue($0, forKey: Constants.avatar) }
        
        return (header as? [String : String]) ?? super.headers
    }
    
    private var requestURLString: String {
        return "\(Constants.baseURL)\(reqestTail)"
    }
}
