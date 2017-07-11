//
//  UICollectionView.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/5/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func dequeueCellWithClass<T>(_ cls: T.Type, for indexPath: IndexPath) -> T {
        let clsString = String(describing: T.self)
        let cell = self.dequeueReusableCell(withReuseIdentifier: clsString, for: indexPath)
        
        return cell as! T
    }

    func registerCell(withClass cls: AnyClass?) {
        cls.map { self.register(UINib.nibWithClass($0), forCellWithReuseIdentifier: String(describing: $0.self)) }
    }
    
    func registerCells(withClasses classes: [AnyClass]?) {
        if classes == nil {
            return
        }
        
        for cls in classes! {
            self.registerCell(withClass: cls)
        }
    }
}
