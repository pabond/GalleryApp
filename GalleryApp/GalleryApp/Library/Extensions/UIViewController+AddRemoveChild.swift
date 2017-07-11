//
//  UIViewController+AddRemoveChild.swift
//  Cagdas
//
//  Created by Artem Chabannyi on 11/8/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func idp_addChildViewController(childController: UIViewController,
                                    atView view: UIView,
                                    atFrame frame:CGRect? = nil) {
        self.addChildViewController(childController)
        let rect = frame ?? view.bounds
        childController.view.frame = rect
        view.addSubview(childController.view)
        childController.didMove(toParentViewController: self)
    }
    
    func idp_addChildViewController(childController: UIViewController,
                                    atFrame frame:CGRect? = nil) {
        self.idp_addChildViewController(childController: childController,
                                        atView: self.view,
                                        atFrame: frame)
    }
    
    func idp_removeChildController(childController: UIViewController) {
        childController.willMove(toParentViewController: nil)
        childController.view.removeFromSuperview()
        childController.removeFromParentViewController()
    }
}
