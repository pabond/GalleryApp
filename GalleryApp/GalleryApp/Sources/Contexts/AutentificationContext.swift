//
//  AutentificationContext.swift
//  GalleryApp
//
//  Created by Bondar Pavel on 7/12/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit

class AutentificationContext: Context {
    internal var password: String!
    internal var avatar: UIImage?
    internal var userName: String?
    internal var email: String!
    internal var success: (()->())?
    internal var fail: (()->())?
    
    internal var reqestTail: String {
        return ""
    }
    
    private var requestURLString: String {
        return "\(Constants.baseURL)\(reqestTail)"
    }
    
    init(email: String,
         password: String,
         avatar: UIImage? = nil,
         userName: String? = nil,
         success: (()->())? = nil,
         fail: (()->())? = nil)
    {
        self.email = email
        self.password = password
        self.avatar = avatar
        self.userName = userName
        self.success = success
        self.fail = fail
    }
    
    override func execute() {
        guard let url = URL(string: requestURLString),
            let wSelf = weakSelf(self) else { return }
        DispatchQueue.ProcessedBackground(backgroundProcessed: { () -> (Bool) in
            var result = false
            var urlRequest = URLRequest(url: url)
            urlRequest.httpRequestMethod(.POST)
            urlRequest.addValuesForKeys(wSelf.headers)
            
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                
                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    print("statusCode: \(statusCode)")
                    result = statusCode != 400
                }
                }.resume()
            
            return result
        }, forgraundProcessed: { (result) in
            result ? wSelf.success?() : wSelf.fail?()
        })
    }
}
