//
//  CountryFlagTableViewController.swift
//  Project1-3 Challenge
//
//  Created by JEONGSEOB HONG on 2021/07/01.
//

import UIKit

class CountryFlagTableViewController: UIViewController {
    var flags: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        readImages()
    }
    
    func readImages() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath
        let readFiles = try! fm.contentsOfDirectory(atPath: path!)
        
        readFiles.forEach { file in
            if file.hasSuffix(".png") {
                flags.append(file)
            }
        }
    }
    
}

extension CountryFlagTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        flags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        let image = UIImage(named: flags[indexPath.row])
        cell.imageView?.image = image?.resize(size: CGSize(width: 30, height: 30))
        cell.textLabel?.text = flags[indexPath.row].replacingOccurrences(of: ".png", with: "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
      
        guard let detailCountryFlagViewController = DetailCountryFlagViewController.create(country: flags[indexPath.row])
        else {
            print("failed DetailCountryFlagViewController instantiate")
            return
        }
        
        navigationController?.pushViewController(detailCountryFlagViewController, animated: true)
        
    }
}
