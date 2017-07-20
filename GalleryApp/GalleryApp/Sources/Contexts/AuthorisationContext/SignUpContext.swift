//
//  SignUpContext.swift
//  GalleryApp
//
//  Created by Bondar Pavel on 7/11/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit
import Alamofire

class SignUpContext: LoginContext {
    
    override var reqestTail: String {
        return "/create"
    }
    
    override func fillMultipartFormData(_ multipartFormData: MultipartFormData) {
        super.fillMultipartFormData(multipartFormData)
        self.userName?.utf8Encoded.map { multipartFormData.append($0, withName: Constants.username) }
        self.avatar
            .flatMap { UIImageJPEGRepresentation($0, 0.1) }
            .map { multipartFormData.append($0,
                                            withName: Constants.avatar,
                                            fileName: "\(Constants.avatar).\(Constants.JPEG)",
                                            mimeType: Constants.imageJPEG) }
    }
}
