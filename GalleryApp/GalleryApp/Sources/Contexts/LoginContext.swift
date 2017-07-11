//
//  LoginContext.swift
//  GalleryApp
//
//  Created by Bondar Pavel on 7/11/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit

class LoginContext: NSObject {
    
    private let reqestTail = "/login"
    
    private var requestURLString: String {
        return "\(Constants.baseURL)\(reqestTail)"
    }
    
    func execute(email: String,
                 password: String,
                 success: (()->())? = nil,
                 fail: (()->())? = nil)
    {
        guard let url = URL(string: requestURLString) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpRequestMethod(.POST)
        urlRequest.addValuesForKeys([
            email : Constants.email,
            password : Constants.password
            ])
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                print("statusCode: \(statusCode)")
                statusCode == 200 ? success?() : fail?()
            }
        }.resume()
    }
}
