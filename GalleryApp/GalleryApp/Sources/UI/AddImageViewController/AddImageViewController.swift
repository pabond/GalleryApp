//
//  AddImageViewController.swift
//  GalleryApp
//
//  Created by Bondar Pavel on 7/17/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit

class AddImageViewController: UIViewController {
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = true;
        self.extendedLayoutIncludesOpaqueBars = true;
        self.edgesForExtendedLayout = .bottom;
        
        addBurButton()
    }
    
    func onDone() {
        
    }
    
    private func addBurButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "OK"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(onDone))
    }
}
