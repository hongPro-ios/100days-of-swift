//
//  ViewController.swift
//  Project18
//
//  Created by JEONGSEOB HONG on 2021/08/11.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("viewDidLoad() method")
        print(1, 2, 3, 4, 5, separator: "-")
        print("Some message", 32, 5, terminator: "heyman")
        print("Some message", 32, 5)
        print("Some message", 32, 5, terminator: "")
        
        assert(1 == 1, "Math failure!")
        
        for i in 1...100 {
            print("Got number \(i)")
        }
    }


}

