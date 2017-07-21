//
//  AuthorisationContext.swift
//  GalleryApp
//
//  Created by Bondar Pavel on 7/12/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit
import Alamofire

class AuthorisationContext: Context {
    internal var password: String!
    internal var avatar: UIImage?
    internal var userName: String?
    internal var email: String!
    
    init(success: ((_ : Any)->())?,
         fail: ((_ : Int?)->())?,
         user: User?,
         password: String,
         email: String,
         avatar: UIImage? = nil,
         userName: String? = nil)
    {
        super.init(user: user, success: success, fail: fail)
        self.email = email
        self.password = password
        self.avatar = avatar
        self.userName = userName
    }
    
    override func processResponse(_ response: DataResponse<Any>) {
        guard let wSelf = weakSelf(self) else { return }
        DispatchQueue.global().async {
            switch(response.result) {
            case .success(let json):
                guard let json = json as? Dictionary<String, Any> else { return }
                (response.response?.statusCode).map {
                    if $0 == 400 || $0 == 401  {
                        wSelf.callCompletion()
                    } else {
                        let user = wSelf.user
                        (json[Constants.avatar].string).map { user?.avatarUrlString = $0 }
                        (json[Constants.creationTime].string).map { user?.creationTime = $0 }
                        (json[Constants.token].string).map { user?.token = $0 }
                        wSelf.callCompletion(user)
                    }
                }
                
                print(json)
            case .failure(let error):
                print(error.localizedDescription)
                wSelf.callCompletion()
            }
        }
    }
}
