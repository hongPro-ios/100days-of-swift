//
//  PhotoTableViewController.swift
//  Projects Consolidation 10-12
//
//  Created by JEONGSEOB HONG on 2021/07/28.
//

import UIKit

class PhotoTableViewController: UITableViewController {
    
    enum UserDefaultsKeys {
        static let photos = "photos"
    }
    
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photo List"

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera,
                                                            target: self,
                                                            action: #selector(takePhoto))
        
        fetchPhotosInfoFromUserDefaults()
        
    }
    
    @objc func takePhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? PhotoTableViewCell else { fatalError("PhotoCell can not use") }
        let photo = photos[indexPath.row]
        
        cell.configure(photo: photo)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let photo = photos[indexPath.row]
        let detailPhotoViewController = DetailPhotoViewController(imagePath: photo.imagePath)
        
        navigationController?.pushViewController(detailPhotoViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle  == .delete {
            tableView.beginUpdates()
            do {
                try FileManager.default.removeItem(atPath: photos[indexPath.row].imagePath)
            } catch {
                fatalError("error form remove photo data ")
            }
            
            photos.remove(at: indexPath.row)
            savePhotosInfoInUserDefaults()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}


extension PhotoTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let photoStorage = Utility.getDocumentsDirectory()
        let photoId = UUID().uuidString
        
        // save original picture
        guard let originalPhoto = info[.originalImage] as? UIImage else { return }
        if let jpegData = originalPhoto.jpegData(compressionQuality: 1) {
            try? jpegData.write(to: photoStorage.appendingPathComponent(photoId))
        }
        
        // reload tableView data
        photos.append(Photo(id: photoId, caption: nil))
        savePhotosInfoInUserDefaults()
        tableView.reloadData()
        dismiss(animated: true)
        
        // Input caption
        let alertController = UIAlertController(title: "Add Caption", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self, weak alertController] _ in
            self?.photos.first { $0.id == photoId }?.caption = alertController?.textFields?[0].text
            self?.savePhotosInfoInUserDefaults()
            self?.tableView.reloadData()
        }))
        alertController.addAction(UIAlertAction(title: "SKIP", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
    
    func savePhotosInfoInUserDefaults() {
        let jsonEncoder = JSONEncoder()
        do {
            let encodedPhotos = try jsonEncoder.encode(photos)
            let userDefaults = UserDefaults.standard
            userDefaults.set(encodedPhotos, forKey: UserDefaultsKeys.photos)
        } catch {
            fatalError("error!! savePhotosInfoInUserDefaults")
        }
    }
    
    func fetchPhotosInfoFromUserDefaults() {
        let userDefaults = UserDefaults.standard
        guard let encodedPhotos = userDefaults.object(forKey: UserDefaultsKeys.photos) as? Data
        else { return }
        
        do {
            let jsonDecoder = JSONDecoder()
            photos = try jsonDecoder.decode([Photo].self, from: encodedPhotos)
        } catch {
            fatalError("error!! photos data dose not exist in UserDefaults")
        }
    }
    
}
