//
//  GalleryImageCell.swift
//  GalleryApp
//
//  Created by Bondar Pavel on 7/16/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit

class GalleryImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
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
}
