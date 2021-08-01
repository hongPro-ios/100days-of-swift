//
//  ViewController.swift
//  Project13
//
//  Created by JEONGSEOB HONG on 2021/07/30.
//

import CoreImage
import UIKit

class ViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var intensity: UISlider!
    @IBOutlet var radius: UISlider!
    @IBOutlet var changeFilterButton: UIButton!
    
    var originalImage: UIImage! // 원본 이미지 저장용
    var context: CIContext! // CIFilter적용된 결과 이미지 타입 변환 및 출력용
    var currentFilter: CIFilter! // 적용 필터
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "YACIFP" // yet another core image filters program
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(importPicture))
        
        context = CIContext()
        currentFilter = CIFilter(name: "CISepiaTone")
    }
    
    @IBAction func changeFilter(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Choose filter", message: nil, preferredStyle: .actionSheet)
        
        let filters = ["CIBumpDistortion", "CIGaussianBlur", "CIPixellate", "CISepiaTone", "CITwirlDistortion", "CIUnsharpMask", "CIVignette"]
        filters.forEach {
            alertController.addAction(UIAlertAction(title: $0,
                                                    style: .default,
                                                    handler: setFilter))
        }
        alertController.addAction(UIAlertAction(title: "Cancel",
                                                style: .cancel))
        
        // This code for iPad, if is not
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
        }
        
        present(alertController, animated: true)
    }
    
    @IBAction func save(_ sender: Any) {
        if let image = imageView.image {
            UIImageWriteToSavedPhotosAlbum(image,
                                           self,
                                           #selector(alertImageSaveCompletion(_:didFinishSavingWithError:contextInfo:)),
                                           nil)
        } else {
            let alertController = UIAlertController(title: "Save error", message: "No image", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertController, animated: true)
        }
  
    }
    @IBAction func intensityChanged(_ sender: Any) {
        applyFilterEffect()
    }
    
    @IBAction func radiusChanged(_ sender: UISlider) {
        applyFilterEffect()
    }
    
    func setFilter(alertAction: UIAlertAction) {
        guard originalImage != nil else { return }
        guard let actionTitle = alertAction.title else { return }
        
        changeFilterButton.setTitle(actionTitle, for: .normal)
        
        currentFilter = CIFilter(name: actionTitle)
        
        let beginImage = CIImage(image: originalImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        applyFilterEffect()
    }
    
    
    func applyFilterEffect() {
        guard let outputImage = currentFilter.outputImage else { return }
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)
        }
        
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(radius.value * 200, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(intensity.value * 10, forKey: kCIInputScaleKey)
        }
        
        if inputKeys.contains(kCIInputCenterKey) {
            currentFilter.setValue(CIVector(x: originalImage.size.width / 2 ,
                                            y: originalImage.size.height / 2),
                                   forKey: kCIInputCenterKey)
        }
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let processedImage = UIImage(cgImage: cgImage)
            imageView.image = processedImage
        }
    }
    
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc func alertImageSaveCompletion(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let alertController = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertController, animated: true)
        } else {
            let alertController = UIAlertController(title: "Saved!", message: "Your alerted image has been saved to your photos", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertController, animated: true)
        }
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        originalImage = image
        
        let targetCIImage = CIImage(image: originalImage)
        currentFilter.setValue(targetCIImage, forKey: kCIInputImageKey)
        applyFilterEffect()
    }
    
}
