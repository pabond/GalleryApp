//
//  AllImagesContext.swift
//  GalleryApp
//
//  Created by Bondar Pavel on 7/17/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit
import Alamofire

class AllImagesContext: Context {
    override var httpMethod : HTTPMethod {
        return .get
    }
    
    override var reqestTail: String {
        return "/all"
    }
    
    override var headers : HTTPHeaders? {
        return self.user.map { [Constants.token : $0.token] }
    }
    
    override func processResponse(_ response: DataResponse<Any>) {
        
        print(response)
        callCompletion()
    }
}
