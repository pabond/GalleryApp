//
//  Realm+Write.swift
//  Elvanto Contacts
//
//  Created by Pavel Bondar on 3/3/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import RealmSwift

let realmIntance = try! Realm()

extension Realm {
    func save(_ block: ()->()) {
        do {
            try realmIntance.safeWrite { block() }
        } catch {
            print(error)
        }
    }
    
    func safeWrite(_ block: (() throws -> Void)) throws {
        if isInWriteTransaction {
            try block()
        } else {
            try write(block)
        }
    }
}
