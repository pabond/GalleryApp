//
//  Email.swift
//  fivePillars
//
//  Created by Bondar Pavel on 6/1/17.
//  Copyright © 2017 AndrewAgapov. All rights reserved.
//

import Foundation

struct Email {
    
    static func isValid(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let result = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return result.evaluate(with: email)
    }
}
