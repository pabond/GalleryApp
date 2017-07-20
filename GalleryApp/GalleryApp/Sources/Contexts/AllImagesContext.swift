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
        guard let wSelf = weakSelf(self) else { return }
        DispatchQueue.global().async {
            switch(response.result) {
            case .success(let json):
                guard let json = json as? Dictionary<String, Any> else { return }
                (response.response?.statusCode).map {
                    if $0 == 400 || $0 == 401  {
                        wSelf.callCompletion(json[Constants.gif])
                    } else {
                        wSelf.user?.images.removeAll()
                        if let images = json[Constants.images] as? Array<Dictionary<String, Any>> {
                            images.forEach { wSelf.parseImage($0).map { wSelf.user?.images.append($0) } }
                        }
                        
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
    
    private func parseImage(_ json: Dictionary<String, Any>) -> GalleryImage? {
        guard let bigImage = json[Constants.bigImagePath].string,
            let smallImage = json[Constants.smallImagePath].string,
            let id = json[Constants.id].int,
            let created = json[Constants.created].string,
            let parameters = json[Constants.parameters] as? Dictionary<String, Any>,
            let weather = parameters[Constants.weather].string,
            let address = parameters[Constants.address].string,
            let latitude = parameters[Constants.latitude].float,
            let longitude = parameters[Constants.longitude].float
            else { return nil }
        
        return GalleryImage.init(imageUrlString: bigImage,
                                 smallImageUrlString: smallImage,
                                 weather: weather,
                                 address: address,
                                 id: id,
                                 created: created,
                                 latitude: latitude,
                                 longitude: longitude)
    }
}
