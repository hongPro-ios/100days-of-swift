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
    
    var countries = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    var score = 0
    var correctAnswerIndex = 0
    var countPlay = 0
    var maxCountPlay = 10
    var highestScore = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHighestScore()
        setupUI()
        askQuestion()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        guard countPlay != maxCountPlay else {
            let alertController = UIAlertController(
                title: "Game Done",
                message: "Your score is \(score)",
                preferredStyle: .alert)
            
            let actionReset = UIAlertAction(
                title: "Reset",
                style: .destructive,
                handler: resetGame)
            
            presentAlert(alertController: alertController, actions: [actionReset])
            return
            
        }
        
        var title: String
        if isAnswered(selectedAnswerIndex: sender.tag) {
            title = "Correct"
          
            score += 1
            if score > highestScore {
                title += " You got highestScore"
                highestScore = score
                saveHighestScore()
            }
            
            
        } else {
            title = "Wrong! That’s the flag of \(countries[sender.tag])"
            score -= 1
        }
        
        updateCountryNameAndScoreOnNavbar()
        
     
        
        let alertController = UIAlertController(
            title: title,
            message: "Your score is \(score)",
            preferredStyle: .alert)
        
        let actionContinue = UIAlertAction(
            title: "Continue",
            style: .default,
            handler: askQuestion)
        
        presentAlert(alertController: alertController, actions: [actionContinue])
    }
    
    func askQuestion(alertAction: UIAlertAction! = nil) {
        countPlay += 1
        countries.shuffle()
        correctAnswerIndex = Int.random(in: 0...2)
        
        firstButton.setImage(UIImage(named: countries[0]), for: .normal)
        secondButton.setImage(UIImage(named: countries[1]), for: .normal)
        thirdButton.setImage(UIImage(named: countries[2]), for: .normal)
        
        updateCountryNameAndScoreOnNavbar()
    }
    
    func setupUI() {
        firstButton.layer.borderWidth = 1
        secondButton.layer.borderWidth = 1
        thirdButton.layer.borderWidth = 1
        
        firstButton.layer.borderColor = UIColor.lightGray.cgColor
        secondButton.layer.borderColor = UIColor.lightGray.cgColor
        thirdButton.layer.borderColor = UIColor.lightGray.cgColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Check score", style: .plain, target: self, action: #selector(alertScore))
    }
    
    @objc func alertScore() {
        let alertScore = UIAlertController(title: "Score", message: "Score is now \(score)", preferredStyle: .alert)
        let alertCloseAction = UIAlertAction(title: "Close", style: .destructive, handler: nil)
        alertScore.addAction(alertCloseAction)
        present(alertScore, animated: true)
    }

    
    func resetGame(alertAction: UIAlertAction! = nil) {
        score = 0
        correctAnswerIndex = 0
        countPlay = 0
        askQuestion()
    }
    
    func updateCountryNameAndScoreOnNavbar() {
        let countryName = countries[correctAnswerIndex].uppercased()
        title = "\(countryName), The Score:\(score)"
    }
    
    func presentAlert(alertController: UIAlertController, actions: [UIAlertAction]) {
        actions.forEach { action in
            alertController.addAction(action)
        }
        present(alertController, animated: true)
    }
    
    func isAnswered(selectedAnswerIndex: Int) -> Bool {
        if selectedAnswerIndex == correctAnswerIndex {
            return true
        } else {
            return false
        }
    }
    
    func saveHighestScore() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(highestScore, forKey: "highestScore")
    }
    
    func loadHighestScore() {
        let userDefaults = UserDefaults.standard
         highestScore = userDefaults.integer(forKey: "highestScore")
    }
}

