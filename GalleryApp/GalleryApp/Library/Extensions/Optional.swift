//
//  Optional.swift
//  GalleryApp
//
//  Created by Bondar Pavel on 7/20/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

extension Optional {
    var string : String? {
        return self as? String
    }
    
    var int : Int? {
        return self as? Int
    }
    
    var float : Float? {
        return self as? Float
    }
}
