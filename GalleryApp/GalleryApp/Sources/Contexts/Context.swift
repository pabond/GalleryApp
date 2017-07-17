//
//  Context.swift
//  GalleryApp
//
//  Created by Bondar Pavel on 7/12/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit
import Alamofire

class Context : NSObject, Weakable {
    internal var success: ((_ : Any)->())?
    internal var fail: (()->())?
    internal var user: User?
    
    private var requestURLString: String {
        return "\(Constants.baseURL)\(reqestTail)"
    }
    
    // MARK: - these variabels can be overwritten in subclasses
    internal var httpMethod : HTTPMethod {
        return .post
    }
    
    internal var reqestTail: String {
        return ""
    }
    
    internal var headers: HTTPHeaders? {
        return [:]
    }
    
    // MARK: - initialization
    
    init(user: User?,
         success: ((_ : Any)->())?,
         fail: (()->())?) {
        self.success = success
        self.fail = fail
        self.user = user
    }
    
    func execute() {
        guard let url = URL(string: requestURLString),
            let urlRequest = try? URLRequest.init(url: url, method: self.httpMethod, headers: self.headers),
            let wSelf = weakSelf(self)
            else { return }
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            wSelf.fillMultipartFormData(multipartFormData)
        }, with: urlRequest) { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    wSelf.processResponse(response)
                }
            case .failure(_):
                wSelf.callCompletion()
            }
        }
    }
    
    func callCompletion(_ model : Any? = nil) {
        DispatchQueue.main.async {
            if let model = model {
                self.success?(model)
            } else {
                self.fail?()
            }
        }
    }
    
    // MARK: - these methods should be overwritten in subclasses
    internal func processResponse(_ response: DataResponse<Any>) {}
    internal func fillMultipartFormData(_ multipartFormData: MultipartFormData) {}
}
