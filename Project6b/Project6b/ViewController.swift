//
//  ViewController.swift
//  Project6b
//
//  Created by JEONGSEOB HONG on 2021/07/08.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIComponents()
    }
    
    
    func setupUIComponents() {
        let label1 = setLabel(text: "WE", bcColor: .red )
        let label2 = setLabel(text: "ARE", bcColor: .blue)
        let label3 = setLabel(text: "SOME", bcColor: .brown)
        let label4 = setLabel(text: "AWSOME", bcColor: .yellow)
        let label5 = setLabel(text: "LABELS", bcColor: .green)
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
        //        let viewsDictionary = [
        //            "label1": label1,
        //            "label2": label2,
        //            "label3": label3,
        //            "label4": label4,
        //            "label5": label5]
        //
        //        for label in viewsDictionary.keys {
        //            view.addConstraints(NSLayoutConstraint.constraints(
        //                                    withVisualFormat: "H:|[\(label)]|",
        //                                    options: [],
        //                                    metrics: nil,
        //                                    views: viewsDictionary))
        //        }
        //
        //        let metrics = ["labelHight": 88]
        //
        //        view.addConstraints(NSLayoutConstraint.constraints(
        //                                withVisualFormat: "V:|[label1(labelHight@@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]-(>=10)-|",
        //                                options: [],
        //                                metrics: metrics,
        //                                views: viewsDictionary))
        
        var previousLabel: UILabel?
        
        for label in [label1, label2, label3, label4, label5] {
            
//            label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
     
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            
//            label.heightAnchor.constraint(equalToConstant: view.bounds.height / 5 - 10).isActive = true
            label.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2, constant: -10).isActive = true
            
            if let previousLabel = previousLabel {
                label.topAnchor.constraint(equalTo: previousLabel.bottomAnchor, constant: 10).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            }
            
            previousLabel = label
        }
        
    }
    
    private func setLabel(text: String, bcColor: UIColor) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = bcColor
        label.text = text
        label.sizeToFit()
        return label
    }
}

