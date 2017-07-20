//
//  GalleryCell.swift
//  GalleryApp
//
//  Created by Bondar Pavel on 7/20/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit

class GalleryCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setShadow()
    }
    
    func fillWith(_ object : GalleryImage?) {
        guard let imageModel = object else { return }
        weatherLabel.text = imageModel.weather
        addressLabel.text = imageModel.address
        URL(string: imageModel.imageUrlString).map {
            imageView.image(withURL: $0)
        }
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        weatherLabel.text = nil
        addressLabel.text = nil
    }
    
    private func setShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 2.0;
        self.layer.shadowOpacity = 0.3;
        self.clipsToBounds = false
        self.layer.masksToBounds = false
    }
}
