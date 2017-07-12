//
//  URRRequest.swift
//  GalleryApp
//
//  Created by Bondar Pavel on 7/11/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import Foundation

enum httpMethodType: String {
    case POST, GET
}

extension URLRequest {
    
    mutating func httpRequestMethod(_ type: httpMethodType) {
        self.httpMethod = type.rawValue
    }
    
    mutating func addValuesForKeys(_ values: [String : String]) {
        values.forEach { self.addValue($0.value, forHTTPHeaderField: $0.key)
        }
    }
}
