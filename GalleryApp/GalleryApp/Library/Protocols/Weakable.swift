//
//  Weakable.swift
//  Elvanto Contacts
//
//  Created by Bondar Pavel on 6/12/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

protocol Weakable {
    
    func weakSelf<SelfType>(_ strongSelf: SelfType) -> SelfType? where SelfType : AnyObject
}

extension Weakable {
    
    func weakSelf<SelfType>(_ strongSelf: SelfType) -> SelfType? where SelfType : AnyObject {
        weak var weakenedSelf = strongSelf
        
        return weakenedSelf
    }
}
