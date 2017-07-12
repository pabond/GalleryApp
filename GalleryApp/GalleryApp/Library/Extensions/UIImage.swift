//
//  UIImage.swift
//  GalleryApp
//
//  Created by Bondar Pavel on 7/11/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit

extension UIImage {
    var base64: String? {
        let dataImage = UIImageJPEGRepresentation(self, 1)
        return dataImage?.base64EncodedString()
    }
}
