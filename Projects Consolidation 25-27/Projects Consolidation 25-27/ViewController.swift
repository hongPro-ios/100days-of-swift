//
//  ViewController.swift
//  Projects Consolidation 25-27
//
//  Created by JEONGSEOB HONG on 2021/09/09.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var importedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(importImage))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareImage))
    }
    
    @objc func importImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true)
        
    }
    
    @objc func shareImage() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8)
        else {
            print("No image found")
            return
        }
        let viewController = UIActivityViewController(activityItems: [image], applicationActivities: [])
        
        // ipad에서는 이게 없으면 crash가 발생한다. 아래의 "ipad대응시 반드시 필요한 구문" 참고
        viewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(viewController, animated: true)
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true)
        
        let image = info[.editedImage] as? UIImage
        importedImage = image
        alertTextInputFormTop(on: .top)
        
    }
    
    func alertTextInputFormTop(on: Position) {
        let alert = UIAlertController(title: "Input text on \(on.rawValue)", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Skip", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Input", style: .default) { [weak self] _ in
            let text = (alert.textFields!.first! as UITextField).text
            self?.importedImage = self?.importedImage?.addText(text, on: on)
            self?.alertTextInputFormBottom(on: .bottom)
        })
        present(alert, animated: true)
    }
    
    func alertTextInputFormBottom(on: Position) {
        let alert = UIAlertController(title: "Input text on \(on.rawValue)", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Skip", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Input", style: .default) { [weak self] _ in
            let text = (alert.textFields!.first! as UITextField).text
            self?.importedImage = self?.importedImage?.addText(text, on: on)
            self?.imageView.image = self?.importedImage
        })
        present(alert, animated: true)
    }
}



extension UIImage {
    func addText(_ text: String?, on: Position) -> UIImage {
        guard let text = text else { return self }
        
        let renderer = UIGraphicsImageRenderer(size: self.size)
        let editedImage = renderer.image { ctx in
            // 1. Add image
            self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) )
            
            // 2. Add Text
            let fontSize: CGFloat = 40
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: fontSize)
            ]
            let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
            
            var yPosition: CGFloat = 10
            switch on {
            case .bottom:
                yPosition = self.size.height - 10 - fontSize
            case .top:
                yPosition = 10
            }
            attributedString.draw(at: CGPoint(x: (self.size.width - attributedString.size().width) / 2, y: yPosition))
        }
        
        return editedImage
        
    }
}

enum Position: String {
    case top, bottom
}
