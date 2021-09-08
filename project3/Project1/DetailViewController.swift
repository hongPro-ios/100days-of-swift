//
//  DetailViewController.swift
//  Project1
//
//  Created by TwoStraws on 12/08/2016.
//  Copyright © 2016 Paul Hudson. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
	@IBOutlet var imageView: UIImageView!
	var selectedImage: String?

    override func viewDidLoad() {
        super.viewDidLoad()

		title = selectedImage
        navigationItem.largeTitleDisplayMode = .never
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

		if let imageToLoad = selectedImage {
            guard let image = UIImage(named: imageToLoad) else { return }
            
            let renderer = UIGraphicsImageRenderer(size: image.size)
            let newImage = renderer.image { ctx in
                image.draw(at: .zero)
                
                let string = "Storm Viewer"
                let attributes: [NSAttributedString.Key : Any] = [
                    .font: UIFont.systemFont(ofSize: 36),
                    .foregroundColor: UIColor.blue,
                ]
                let attributedString = NSAttributedString(string: string, attributes: attributes)
                attributedString.draw(at: CGPoint(x: image.size.width / 2 - 100, y: 80))
//                attributedString.draw(with: CGRect(x: image.size.width / 2,
//                                                   y: image.size.height / 2,
//                                                   width: 100,
//                                                   height: 100),
//                                      options: .usesLineFragmentOrigin,
//                                      context: nil)
                
            }
            
            imageView.image = newImage
		}
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

	@objc func shareTapped() {
		let vc = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: [])
		vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
		present(vc, animated: true)
	}
}
