//
//  DetailCountryFlagViewController.swift
//  Project1-3 Challenge
//
//  Created by JEONGSEOB HONG on 2021/07/01.
//

import UIKit

class DetailCountryFlagViewController: UIViewController {
    @IBOutlet var flagImageView: UIImageView!
    
    var country: String?
    var flagImage: UIImage?
    
    static func create(country: String) -> DetailCountryFlagViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailCountryFlagViewController = storyboard.instantiateViewController(withIdentifier: "DetailCountryFlagViewController")  as? DetailCountryFlagViewController
        detailCountryFlagViewController?.country = country
        return detailCountryFlagViewController
    }
    
    override func viewDidLoad() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareFlagInfo))
        
        flagImage = UIImage(named: country!)
        
        title = country?.replacingOccurrences(of: ".png", with: "")
        setupFlagImage()
    }
    
    @objc func shareFlagInfo() {
        
        guard
            let country = country,
            let flagImage = flagImage
        else { return }
        
        let activityViewController = UIActivityViewController(activityItems: [country, flagImage], applicationActivities: [])
        
        activityViewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(activityViewController, animated: true)
        
    }
    
    func setupFlagImage() {
        flagImageView.image = UIImage(named: country!)
    }
}
