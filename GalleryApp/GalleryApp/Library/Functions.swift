//
//  Functions.swift
//  Elvanto Contacts
//
//  Created by Bondar Pavel on 6/12/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import Foundation

func cast<ValueType, CastType>(_ valueToCast: ValueType) -> CastType? {
    return valueToCast as? CastType
}
