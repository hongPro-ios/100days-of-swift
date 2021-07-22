//
//  ImageCollectionViewCell.swift
//  Project1
//
//  Created by JEONGSEOB HONG on 2021/07/22.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var imageNameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        imageNameLabel.text = ""
    }
    
    func configure(imageName: String) {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.cornerRadius = 8
        
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.cornerRadius = 4
        
        imageNameLabel.layer.borderWidth = 1
        imageNameLabel.layer.borderColor = UIColor.black.cgColor
        contentView.layer.cornerRadius = 4
        
        imageView.image = UIImage(named: imageName)
        imageNameLabel.text = imageName
    }
}
