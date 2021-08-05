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
    
    private var originalImage: UIImage! // 원본 이미지 저장용
    private var coreImageContext: CIContext! // CIFilter적용된 결과 이미지 타입 변환 및 출력용
    private var currentCIFilter: CIFilter! // 적용 필터
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "YACIFP" // yet another core image filters program
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(importPicture))
        
        coreImageContext = CIContext()
        
        setFilterType(filterTypeString: "CISepiaTone")
    }
    
    @IBAction func changeFilter(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Choose filter", message: nil, preferredStyle: .actionSheet)
        
        let filters = ["CIBumpDistortion", "CIGaussianBlur", "CIPixellate", "CISepiaTone", "CITwirlDistortion", "CIUnsharpMask", "CIVignette"]
        filters.forEach {
            alertController.addAction(UIAlertAction(title: $0,
                                                    style: .default,
                                                    handler: changeFilterType))
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
        adjustFilterEffectValue()
        imageView.image = outputUIImageWithFiltered()
    }
    
    @IBAction func radiusChanged(_ sender: UISlider) {
        adjustFilterEffectValue()
        imageView.image = outputUIImageWithFiltered()
    }
    
    func changeFilterType(alertAction: UIAlertAction) {
        guard let filterTypeString = alertAction.title else { return }
        setFilterType(filterTypeString: filterTypeString)
    }
    
    func setFilterType(filterTypeString: String) {
        changeFilterButton.setTitle(filterTypeString, for: .normal)
        
        currentCIFilter = CIFilter(name: filterTypeString)
        
        imageView.image = applyFilterEffect(to: originalImage)
    }
    
    func adjustFilterEffectValue() {
        let inputKeys = currentCIFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            currentCIFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentCIFilter.setValue(radius.value * 200, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentCIFilter.setValue(intensity.value * 10, forKey: kCIInputScaleKey)
        }
        
        if inputKeys.contains(kCIInputCenterKey) {
            currentCIFilter.setValue(CIVector(x: originalImage.size.width / 2 ,
                                            y: originalImage.size.height / 2),
                                   forKey: kCIInputCenterKey)
        }
        
    }
    
    func applyFilterEffect(to originalImage: UIImage?) -> UIImage? {
        guard let originalImage = originalImage else { return nil }
        
        // step1: input original image
        let targetCIImage = CIImage(image: originalImage)
        currentCIFilter.setValue(targetCIImage, forKey: kCIInputImageKey)
        
        // step2: set filter value
        adjustFilterEffectValue()
        
        // step3: output filtered image
        return outputUIImageWithFiltered()
    }
    
    func outputUIImageWithFiltered() -> UIImage? {
        guard let outputImage = currentCIFilter.outputImage else { return nil }
        guard let cgImage = coreImageContext.createCGImage(outputImage, from: outputImage.extent) else { return nil }
        
        return UIImage(cgImage: cgImage)
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
        imageView.alpha = 0
        imageView.image = applyFilterEffect(to: originalImage)
        UIView.animate(withDuration: 2) {
            self.imageView.alpha = 1
        }
    }
}
