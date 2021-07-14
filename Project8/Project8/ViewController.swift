//
//  ViewController.swift
//  Project8
//
//  Created by JEONGSEOB HONG on 2021/07/14.
//

import UIKit

class ViewController: UIViewController {
    var scoreLabel: UILabel!
    var cluesLabel: UILabel!
    var answersLabel: UILabel!
    var currentAnswer: UITextField!
    var submitButton: UIButton!
    var clearButton: UIButton!
    var letterButtons = [UIButton]()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score : 0"
        view.addSubview(scoreLabel)
        
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = .systemFont(ofSize: 24)
        cluesLabel.text = "CLUES"
        cluesLabel.numberOfLines = 0
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(cluesLabel)
        
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = .systemFont(ofSize: 24)
        answersLabel.text = "ANSWERS"
        answersLabel.textAlignment = .right
        answersLabel.numberOfLines = 0
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(answersLabel)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = .systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
        
        submitButton = UIButton(type: .system)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle("SUBMIT", for: .normal)
        view.addSubview(submitButton)
        
        clearButton = UIButton(type: .system)
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.setTitle("CLEAR", for: .normal)
        view.addSubview(clearButton)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        
        NSLayoutConstraint.activate([
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
            
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
            
            currentAnswer.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            submitButton.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 44),
            
            clearButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            clearButton.centerYAnchor.constraint(equalTo: submitButton.centerYAnchor),
            clearButton.heightAnchor.constraint(equalTo: submitButton.heightAnchor),
            
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 20),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.heightAnchor.constraint(equalToConstant: 320)
        ])
        
        let width = 150
        let height = 80
        
        for row in 0..<4 {
            for column in 0..<5 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = .systemFont(ofSize: 36)
                letterButton.setTitle("WWW", for: .normal)
                letterButton.layer.borderWidth = 1
                letterButton.layer.borderColor = UIColor.black.cgColor

                let frame = CGRect(x: column * width,
                                   y: row * height,
                                   width: width,
                                   height: height)
                letterButton.frame = frame

                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
            }
         }
        
//        cluesLabel.backgroundColor = .red
//        answersLabel.backgroundColor = .blue
//        buttonsView.backgroundColor = .brown
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}

