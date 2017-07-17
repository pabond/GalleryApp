//
//  GIFContext.swift
//  GalleryApp
//
//  Created by Bondar Pavel on 7/17/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit
import Alamofire

class GIFContext: Context {
    override var httpMethod : HTTPMethod {
        return .get
    }
    
    override var reqestTail: String {
        return "/gif"
    }
    
    override func fillMultipartFormData(_ multipartFormData: MultipartFormData) {
         _ = self.user?.weather.map {
            multipartFormData.append(NSKeyedArchiver.archivedData(withRootObject: $0), withName: Constants.weather)
        }
    }
    
    override var headers : HTTPHeaders? {
        return self.user.map { [Constants.token : $0.token] }
    }
    
    override func processResponse(_ response: DataResponse<Any>) {
        print(response)
        guard let wSelf = weakSelf(self) else { return }
        DispatchQueue.global().async {
            switch(response.result) {
            case .success(let json):
                guard let json = json as? Dictionary<String, Any> else { return }
                (response.response?.statusCode).map {
                    if $0 == 400 || $0 == 401  {
                        wSelf.callCompletion(json[Constants.gif])
                    } else {
                        var user = self.user
                        (json[Constants.avatar] as? String).map { user?.avatarUrlString = $0 }
                        (json[Constants.creationTime] as? String).map { user?.creationTime = $0 }
                        (json[Constants.token] as? String).map { user?.token = $0 }
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
