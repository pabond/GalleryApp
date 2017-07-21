//
//  GIFViewController.swift
//  GalleryApp
//
//  Created by Bondar Pavel on 7/17/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit
import SwiftGifOrigin

class GIFViewController: UIViewController, RootViewGettable {
    typealias RootViewType = GIFView
    
    var slideInTransitioningDelegate = SlideInPresentationManager()
    
    var user: User?
    var image: GalleryImage?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        setupTransition()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -
    //MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onCancel(_:)))
        view.addGestureRecognizer(tapGesture)
        
        rootView?.contentView.loading = true
        loadGIF()
    }
    
    func setupTransition() {
        slideInTransitioningDelegate.direction = .bottom
        slideInTransitioningDelegate.size = .twoThirds
        self.transitioningDelegate = slideInTransitioningDelegate
        self.modalPresentationStyle = .custom
    }
    
    //MARK: -
    //MARK: Interface Handling
    
    func onCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: -
    //MARK: Private functions
    
    private func loadGIF() {
        let context = GIFContext(user: user, success: { [weak self] (gifURLString) in
            print(gifURLString)
            if let gifURLString = gifURLString as? String {
                self?.rootView?.GIFImageView.image = UIImage.gif(url: gifURLString)
            }
            
            self?.rootView?.contentView.loading = false
        }) { [weak self] (value) in
            self?.rootView?.contentView.loading = false
            self?.onCancel(false)
        }
        
        context.execute()
    }
}
