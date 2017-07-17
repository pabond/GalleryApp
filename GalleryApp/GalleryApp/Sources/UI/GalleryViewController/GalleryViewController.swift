//
//  GalleryViewController.swift
//  GalleryApp
//
//  Created by Bondar Pavel on 7/12/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit

fileprivate let inset: CGFloat = 10
fileprivate let cellsPerRow: CGFloat = 2

class GalleryViewController: UIViewController, RootViewGettable {
    typealias RootViewType = GalleryView
    
    var user : User?
    var images: [GalleryImage]? {
        return user?.images
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBurButtons()
        loadImages()
    }
    
    private func loadImages() {
        rootView?.loading = true
        let context = AllImagesContext(user: self.user, success: { [weak self] (user) in
            self?.rootView?.collectionView?.reloadData()
            self?.rootView?.loading = false
        }) { [weak self] in
            self?.rootView?.loading = false
        }
        
        context.execute()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    
    }
    
    func onLogout() {
        
    }
    
    func onPlay() {
        guard let controller = GIFViewController.viewController() as? GIFViewController else { return }
        controller.user = self.user
        self.present(controller, animated: true)
    }
    
    func onAdd() {
        
    }
    
    private func addBurButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Logout"), style: .plain, target: self, action: #selector(onLogout))
        addRigthButtons()
    }
    
    private func addRigthButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "PlayGIF"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(onPlay))
        navigationItem.rightBarButtonItems?.append(UIBarButtonItem(image: #imageLiteral(resourceName: "AddImage"),
                                                                   style: .plain,
                                                                   target: self,
                                                                   action: #selector(onAdd)))
    }
}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCellWithClass(GalleryImageCell.self, for: indexPath)
        let object = images?[indexPath.row]
        cell.fillWith(object)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        
    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let height = collectionView.frame.width / cellsPerRow
        let width = height - inset
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return inset
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return inset
    }
}

