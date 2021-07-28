//
//  DetailPhotoViewController.swift
//  Projects Consolidation 10-12
//
//  Created by JEONGSEOB HONG on 2021/07/28.
//

import UIKit

class DetailPhotoViewController: UIViewController {
    var imagePath: String
    
    init(imagePath: String) {
        self.imagePath = imagePath
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = UIImageView(image: UIImage(contentsOfFile: imagePath))
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}
