//
//  ViewController.swift
//  Project2
//
//  Created by JEONGSEOB HONG on 2021/06/27.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var firstButton: UIButton!
    @IBOutlet var secondButton: UIButton!
    @IBOutlet var thirdButton: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fileManager = FileManager.default
        let path = Bundle.main.resourcePath!
        let names = try! fileManager.contentsOfDirectory(atPath: path)
        
        print(names)
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        setupUI()
        askQuestion()
    }
    
    func askQuestion(alertAction: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        firstButton.setImage(UIImage(named: countries[0]), for: .normal)
        secondButton.setImage(UIImage(named: countries[1]), for: .normal)
        thirdButton.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased()
    }
    
    func setupUI() {
        firstButton.layer.borderWidth = 1
        secondButton.layer.borderWidth = 1
        thirdButton.layer.borderWidth = 1
        
        firstButton.layer.borderColor = UIColor.lightGray.cgColor
        secondButton.layer.borderColor = UIColor.lightGray.cgColor
        thirdButton.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        
        let alertController = UIAlertController(
            title: title,
            message: "Your score is \(score)",
            preferredStyle: .alert)
        
        let actionContinue = UIAlertAction(
            title: "Continue",
            style: .default,
            handler: askQuestion)
        
        alertController.addAction(actionContinue)
        
        present(alertController, animated: true)
        
    }
}

