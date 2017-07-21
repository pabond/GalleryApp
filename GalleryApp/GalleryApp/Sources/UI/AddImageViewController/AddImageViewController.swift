//
//  AddImageViewController.swift
//  GalleryApp
//
//  Created by Bondar Pavel on 7/17/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit
import Photos
import AssetsLibrary

class AddImageViewController: UIViewController, RootViewGettable {
    typealias RootViewType = AddImageView
    var user : User?
    var imageAdded : (()->())?
    
    fileprivate var image : NewImage?
    fileprivate var pickedImage : UIImage? {
        didSet {
            self.rootView?.imageView.image = pickedImage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = true;
        self.extendedLayoutIncludesOpaqueBars = true;
        self.edgesForExtendedLayout = .bottom;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        addBurButton()
    }

    @IBAction func onImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true)
        }
    }
    
    func onDone(_ sender : Any) {
        self.rootView?.loading = true
        if var image = image {
            self.rootView?.descriptionTextField.text.map { image.description = $0 }
            self.rootView?.hashTagTextField.text.map { image.hashTags = $0 }
            let context = AddImageContext(user: user,
                                          success: { [weak self] (obj) in
                                            self?.rootView?.loading = false
                                            self?.imageAdded?()
                                            self?.popCurrentViewController()
                                        },
                                          fail: { [weak self] (value) in
                                            if value == 403 {
                                                self?.navigationController?.dismiss(animated: true)
                                            }
                                            
                                            self?.rootView?.loading = false
                                            self?.infoAlert(title: "Fail", text: "Failed to upload image")
                                        },
                                          image: image)
            
            context.execute()
        } else {
            infoAlert(title: "Image invalid", text: "Please select valid image to upload")
        }
    }
    
    private func addBurButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "OK"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(onDone(_:)))
    }
}

extension AddImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage].flatMap { $0 as? UIImage }
        
        if let image = image {
            if image.size.width * image.scale < 600 {
                picker.infoAlert(title: "Image size is to small", text: "Please select another image. ")
                
                return
            } else {
                self.pickedImage = image
            }
        }
    
        if let URL = info[UIImagePickerControllerReferenceURL] as? URL {
            let opts = PHFetchOptions()
            opts.fetchLimit = 1
            let asset = PHAsset.fetchAssets(withALAssetURLs: [URL], options: opts).firstObject
            let location = asset?.location
            let latitude = (location?.coordinate.latitude).map { Float($0) } ?? 0
            let longitude = (location?.coordinate.longitude).map { Float($0) } ?? 0
                
            self.image = image.map {
                NewImage(image: $0,
                        longitude: longitude,
                        latitude: latitude,
                        description: "",
                        hashTags: "")
            }
        }
        
        picker.dismiss(animated: true)
    }
}
