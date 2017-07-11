//
//  UIImageView + KingfisherLoad.swift
//  Elvanto Contacts
//
//  Created by Pavel Bondar on 4/3/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func image(withURL url: URL?) {
        self.kf.setImage(with: url)
    }
}
