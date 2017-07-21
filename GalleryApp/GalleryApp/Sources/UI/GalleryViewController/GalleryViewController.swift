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
    
    private var refreshControl: UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBurButtons()
        loadImages()
        setUpRefresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    
        rootView?.collectionView?.reloadData()
    }
    
    func onLogout() {
        navigationController?.dismiss(animated: true)
    }
    
    func onPlay() {
        guard let controller = GIFViewController.viewController() as? GIFViewController else { return }
        controller.user = self.user
        self.present(controller, animated: true)
    }
    
    func onAdd() {
        guard let controller = AddImageViewController.viewController() as? AddImageViewController else { return }
        controller.user = self.user
        controller.imageAdded = loadImages
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func update(_ refresh: UIRefreshControl) {
        refresh.beginRefreshing()
        self.loadImages()
    }
    
    func loadImages() {
        rootView?.loading = true
        let context = AllImagesContext(user: self.user, success: { [weak self] (user) in
            self?.rootView?.collectionView?.reloadData()
            self?.rootView?.loading = false
            self?.refreshControl?.endRefreshing()
        }) { [weak self] (value) in
            if value == 403 {
                self?.onLogout()
            }
            
            self?.rootView?.loading = false
            self?.refreshControl?.endRefreshing()
        }
        
        context.execute()
    }
    
    private func addBurButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Logout"), style: .plain, target: self, action: #selector(onLogout))
        addRigthButtons()
    }
    
    private func addRigthButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "AddImage"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(onAdd))
        navigationItem.rightBarButtonItems?.append(UIBarButtonItem(image: #imageLiteral(resourceName: "PlayGIF"),
                                                                   style: .plain,
                                                                   target: self,
                                                                   action: #selector(onPlay)))
    }
    
    private func setUpRefresh() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(update(_:)), for: .valueChanged)
        refreshControl.map { rootView?.collectionView?.addSubview($0) }
    }
}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCellWithClass(GalleryCell.self, for: indexPath)
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
        let height = collectionView.frame.width / cellsPerRow + inset * 2
        let width = height - inset * 3.5
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
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
}

