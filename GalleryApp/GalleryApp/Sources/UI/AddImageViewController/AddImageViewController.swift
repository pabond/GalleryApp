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
        if var image = image {
            self.rootView?.descriptionTextField.text.map { image.description = $0 }
            self.rootView?.hashTagTextField.text.map { image.hashTags = $0 }
            let context = AddImageContext(user: user,
                                          success: { [weak self] (obj) in
                                            self?.navigationController?.popViewControllerWithHandler(completion: {
                                                self?.infoAlert(title: "Success", text: "Image successfully uploaded")
                                            })
                                        },
                                          fail: { [weak self] in
                                            self?.infoAlert(title: "Fail", text: "Failed to upload image")
                                        },
                                          image: image)
            
            context.execute()
        } else {
            infoAlert(title: "Image not selected", text: "Please select image to upload")
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
        info[UIImagePickerControllerOriginalImage]
            .flatMap { $0 as? UIImage }
            .map { self.pickedImage = $0 }
        
        if let URL = info[UIImagePickerControllerReferenceURL] as? URL {
            let opts = PHFetchOptions()
            opts.fetchLimit = 1
            let asset = PHAsset.fetchAssets(withALAssetURLs: [URL], options: opts).firstObject
            if let location = asset?.location {
                let latitude = location.coordinate.latitude
                let longitude = location.coordinate.longitude
                
                self.image = self.pickedImage.map {
                    NewImage(image: $0,
                             longitude: Float(longitude),
                             latitude: Float(latitude),
                             description: "",
                             hashTags: "")
                }
            }
        }
        
        picker.dismiss(animated: true)
    }
}
