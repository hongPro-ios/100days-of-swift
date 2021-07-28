//
//  PhotoTableViewCell.swift
//  Projects Consolidation 10-12
//
//  Created by JEONGSEOB HONG on 2021/07/28.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var captionLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
        dateLabel.text = ""
        captionLabel.text = ""
    }
    
    func configure(photo: Photo) {
        dateLabel.text = photo.id
        captionLabel.text = photo.caption
        photoImageView?.image = UIImage(contentsOfFile: photo.imagePath)
        photoImageView?.contentMode = .scaleAspectFill
        photoImageView.layer.cornerRadius = 8
    }

}
