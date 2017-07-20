//
//  DataConvertable.swift
//  GalleryApp
//
//  Created by Bondar Pavel on 7/19/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import Foundation

protocol DataConvertible {
    init?(data: Data)
    var data: Data { get }
}

extension DataConvertible {
    
    init?(data: Data) {
        guard data.count == MemoryLayout<Self>.size else { return nil }
        self = data.withUnsafeBytes { $0.pointee }
    }
    
    var data: Data {
        var value = self
        return Data(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }
}

extension Int : DataConvertible { }
extension Float : DataConvertible { }
extension Double : DataConvertible { }
