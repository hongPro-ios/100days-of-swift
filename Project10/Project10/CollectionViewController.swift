//
//  ViewController.swift
//  Project10
//
//  Created by JEONGSEOB HONG on 2021/07/20.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    var people = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                           target: self,
                                                           action: #selector(addNewPerson))
    }
    
    @objc func addNewPerson() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        people.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else { fatalError("Unable to dequeue PersonCell") }
        cell.layer.cornerRadius = 7
        
        let person = people[indexPath.item]
        cell.name.text = person.name
        
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
    
        return cell
    }
}

extension CollectionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        collectionView.reloadData()
        
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]
        showAskingRenameOrDeleteAlert(selectedPerson: person, indexPath: indexPath)
    
    }
    
    func showAskingRenameOrDeleteAlert(selectedPerson person: Person, indexPath: IndexPath) {
        let alertController = UIAlertController(title: "What do you want to!",
                                                message: nil,
                                                preferredStyle: .alert)
    
        alertController.addAction(UIAlertAction(title: "RENAME",
                                                style: .default,
                                                handler: { [weak self, weak person] _ in
                                                    guard let person = person else { return }
                                                    self?.showRenameAlert(selectedPerson: person)
                                                }))
        alertController.addAction(UIAlertAction(title: "DELETE",
                                                style: .default,
                                                handler: { [weak self] _ in
                                                    self?.people.remove(at: indexPath.item)
                                                    self?.collectionView.reloadData()
                                                }))
        alertController.addAction(UIAlertAction(title: "CANCEL",
                                                style: .cancel))
        
        present(alertController, animated: true)
    }
    
    func showRenameAlert(selectedPerson person: Person) {
        let alertController = UIAlertController(title: "Rename person",
                                                message: nil,
                                                preferredStyle: .alert)
        alertController.addTextField()
        alertController.addAction(UIAlertAction(title: "OK",
                                                style: .default,
                                                handler: { [weak self, weak alertController] _ in
                                                    guard let newName = alertController?.textFields?[0].text else { return }
                                                    person.name = newName
                                                    self?.collectionView.reloadData()
                                                }))
        alertController.addAction(UIAlertAction(title: "CANCEL",
                                                style: .cancel))
        
        present(alertController, animated: true)
    }
}
