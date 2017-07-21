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
  //      multipartFormData.append(NSKeyedArchiver.archivedData(withRootObject: []), withName: Constants.weather)
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
                    if $0 == 400 || $0 == 403  {
                        wSelf.callCompletion($0)
                    } else {
                        wSelf.callCompletion(json[Constants.gif])
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
