//
//  AddImageContext.swift
//  GalleryApp
//
//  Created by Bondar Pavel on 7/18/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit
import Alamofire

class AddImageContext: Context {
    var image : NewImage?
    
    override var reqestTail: String {
        return "/image"
    }
    
    init(user: User?, success: ((_: Any) -> ())?, fail: (() -> ())?, image: NewImage?) {
        super.init(user: user, success: success, fail: fail)
        self.image = image
    }
    
    override var headers : HTTPHeaders? {
        return self.user.map { [Constants.token : $0.token] }
    }
    
    override func fillMultipartFormData(_ multipartFormData: MultipartFormData) {
        guard let image = image else { return }
        UIImageJPEGRepresentation(image.image, 0.1)
            .map { multipartFormData.append($0,
                                            withName: Constants.image,
                                            fileName: "\(Constants.image).\(Constants.JPEG)",
                                            mimeType: Constants.imageJPEG) }
        image.description.utf8Encoded.map { multipartFormData.append($0, withName: Constants.description) }
        image.hashTags.utf8Encoded.map { multipartFormData.append($0, withName: Constants.hashtag) }
        multipartFormData.append(image.latitude.data, withName: Constants.latitude)
        multipartFormData.append(image.longitude.data, withName: Constants.longitude)
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
                        wSelf.callCompletion(wSelf.user)
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
