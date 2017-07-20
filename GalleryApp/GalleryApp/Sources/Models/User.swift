//
//  User.swift
//  GalleryApp
//
//  Created by Bondar Pavel on 7/11/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit

class User : NSObject {
    var avatarUrlString : String = ""
    var creationTime : String = ""
    var token : String = ""
    var images : [GalleryImage] = []
    
    var avatarURL: URL? {
        return URL(string: avatarUrlString)
    }
}
