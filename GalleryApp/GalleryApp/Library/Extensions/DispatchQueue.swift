//
//  DispatchQueue.swift
//  Elvanto Contacts
//
//  Created by Bondar Pavel on 6/12/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import Foundation

extension DispatchQueue {
    
    internal static func ProcessedBackground<Result>(backgroundProcessed: @escaping ()->(Result),
                                             forgraundProcessed: @escaping (Result)->())
    {
        DispatchQueue.global().async {
            let result = backgroundProcessed()
            DispatchQueue.main.async {
                forgraundProcessed(result)
            }
        }
    }
}
