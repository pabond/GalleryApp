//
//  String.swift
//  Heart
//
//  Created by Bondar Pavel on 1/12/17.
//  Copyright © 2017 Martynets Ruslan. All rights reserved.
//

import Foundation

extension String {
    
    var utf8Encoded : Data? {
        return self.data(using: String.Encoding.utf8)
    }
    
    var idp_localized: String {
        return NSLocalizedString(self, comment: self)
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let result = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return result.evaluate(with: self)
    }
    
//    var isValidPhone: Bool {
//        if self.isEmpty {
//            return false
//        }
//        
//        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
//        let inputString = self.components(separatedBy: charcterSet)
//        let filtered = inputString.joined(separator: "")
//        
//        return self == filtered
//    }
    
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.characters.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.characters.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    func containsStrict(_ find: String) -> Bool {
        return range(of: find) != nil
    }
    
    func contains(_ find: String) -> Bool {
        return self.lowercased().range(of: find.lowercased()) != nil
    }

    public func index(of char: Character) -> Int? {
        if let idx = characters.index(of: char) {
            return characters.distance(from: startIndex, to: idx)
        }
        
        return nil
    }
    
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
