//
//  DetailViewController.swift
//  Project1
//
//  Created by JEONGSEOB HONG on 2021/06/25.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedImage
        
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareApp))
        assert(!(selectedImage == nil), "selectedImage is nil")
        if let imageToLoad = selectedImage {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let loadedImage = UIImage(named: imageToLoad)
                DispatchQueue.main.async {
                    self?.imageView.image = loadedImage
                }
            }
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
    
   @objc func shareApp() {
    let items: [Any] = [URL(string: "https://www.apple.com")!]
    let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
    
    ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
    
    present(ac, animated: true)
    }
}
