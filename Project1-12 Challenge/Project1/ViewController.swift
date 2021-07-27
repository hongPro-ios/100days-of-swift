//
//  ViewController.swift
//  Project1
//
//  Created by JEONGSEOB HONG on 2021/06/24.
//

import UIKit

struct Image: Codable {
    var name: String
    var shownCount: Int = 0
}

class ViewController: UITableViewController {
    var images = [Image]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        performSelector(inBackground: #selector(fetchPictures), with: self)
        
        loadDataFromUserDefaults()
    }
    
    @objc func fetchPictures() {
        let fileManager = FileManager.default
        let path = Bundle.main.resourcePath!
        let imageFileNames = try! fileManager.contentsOfDirectory(atPath: path)
        
        for imageName in imageFileNames {
            if imageName.hasPrefix("nssl") {
                images.append(Image(name: imageName))
            }
        }
        images.sort { $0.name > $1.name }
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadDataFromUserDefaults()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        images.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = "Picture \(indexPath.row + 1) of \(images.count)"
        cell.detailTextLabel?.text = "\(images[indexPath.row].shownCount)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            viewController.selectedImage = images[indexPath.row].name
            navigationController?.pushViewController(viewController, animated: true)
            images[indexPath.row].shownCount += 1
            saveDataFromUserDefaults()
        }
    }
    
    func saveDataFromUserDefaults() {
        let jsonEncoder = JSONEncoder()
        let encodedImage = try? jsonEncoder.encode(images)
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(encodedImage, forKey: "images")
    }
    
    func loadDataFromUserDefaults() {
        let userDefaults = UserDefaults.standard
        if let loadedImagesData = userDefaults.object(forKey: "images") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                images = try jsonDecoder.decode([Image].self, from: loadedImagesData)
            } catch {
                print("Fail to decoding images data")
            }
        }
    }
}
