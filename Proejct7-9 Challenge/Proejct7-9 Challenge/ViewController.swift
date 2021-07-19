//
//  ViewController.swift
//  Proejct7-9 Challenge
//
//  Created by JEONGSEOB HONG on 2021/07/19.
//

import UIKit

class ViewController: UIViewController {
    var wordList: [String] = []
    var answer: String = ""
    var life: Int = 7 {
        didSet {
            lifeLabel.text = "life : \(life)"
        }
    }
    let lifeLabel: UILabel = {
        let lifeLabel = UILabel()
        lifeLabel.text = "life : ?"
        lifeLabel.font = .systemFont(ofSize: 24)
        lifeLabel.translatesAutoresizingMaskIntoConstraints = false
        return lifeLabel
    }()
    let quizWordLabel: UILabel = {
        let quizWordLabel = UILabel()
        quizWordLabel.text = "quizWordLabel"
        quizWordLabel.font = .systemFont(ofSize: 24)
        quizWordLabel.translatesAutoresizingMaskIntoConstraints = false
        return quizWordLabel
    }()
    let alphabetButtonsView: UIView = {
        let alphabetButtonsView = UIView()
        alphabetButtonsView.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        alphabetButtonsView.translatesAutoresizingMaskIntoConstraints = false
        return alphabetButtonsView
    }()
    let alphabetButtons: [UIButton] = {
        var alphabetButtons = [UIButton]()
        let alphabetList = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
        alphabetList.forEach { alphabet in
            let alphabetButton = UIButton(type: .system)
            alphabetButton.setTitle(alphabet, for: .normal)
            alphabetButton.titleLabel?.font = .systemFont(ofSize: 24)
            alphabetButton.layer.borderWidth = 4
            alphabetButton.layer.borderColor = UIColor.gray.cgColor
            alphabetButton.addTarget(self, action: #selector(checkAlphabet), for: .touchUpInside)
            alphabetButtons.append(alphabetButton)
        }
        return alphabetButtons
    }()
    let answerInputTextField: UITextField = {
        let answerInputTextField = UITextField()
        answerInputTextField.placeholder = "Input Answer!!"
        answerInputTextField.layer.borderWidth = 1
        answerInputTextField.layer.borderColor = UIColor.gray.cgColor
        answerInputTextField.autocapitalizationType = UITextAutocapitalizationType.none
        answerInputTextField.translatesAutoresizingMaskIntoConstraints = false
        return answerInputTextField
    }()
    let submitButton: UIButton = {
        let submitButton = UIButton(type: .system)
        submitButton.setTitle("SUBMIT", for: .normal)
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.gray.cgColor
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.addTarget(self, action: #selector(tappedSubmitButton), for: .touchUpInside)
        return submitButton
    }()
    let clearButton: UIButton = {
        let clearButton = UIButton(type: .system)
        clearButton.setTitle("CLEAR", for: .normal)
        clearButton.layer.borderWidth = 1
        clearButton.layer.borderColor = UIColor.gray.cgColor
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.addTarget(self, action: #selector(tappedClearButton), for: .touchUpInside)
        return clearButton
    }()
    let resetButton: UIButton = {
        let resetButton = UIButton(type: .system)
        resetButton.setTitle("RESET", for: .normal)
        resetButton.layer.borderWidth = 1
        resetButton.layer.borderColor = UIColor.gray.cgColor
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.addTarget(self, action: #selector(tappedResetButton), for: .touchUpInside)
        return resetButton
    }()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        view.addSubview(lifeLabel)
        view.addSubview(quizWordLabel)
        view.addSubview(alphabetButtonsView)
        view.addSubview(answerInputTextField)
        view.addSubview(submitButton)
        view.addSubview(clearButton)
        view.addSubview(resetButton)
        
        NSLayoutConstraint.activate([
            lifeLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            lifeLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            resetButton.topAnchor.constraint(equalTo: lifeLabel.topAnchor),
            resetButton.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -20),
            
            quizWordLabel.topAnchor.constraint(equalTo: lifeLabel.bottomAnchor, constant: 20),
            quizWordLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            
            alphabetButtonsView.topAnchor.constraint(equalTo: quizWordLabel.bottomAnchor, constant: 20),
            alphabetButtonsView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            alphabetButtonsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            alphabetButtonsView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor, multiplier: 0.4),
            
            answerInputTextField.topAnchor.constraint(equalTo: alphabetButtonsView.bottomAnchor, constant: 40),
            answerInputTextField.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            answerInputTextField.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            
            submitButton.topAnchor.constraint(equalTo: answerInputTextField.topAnchor),
            submitButton.leftAnchor.constraint(equalTo: answerInputTextField.rightAnchor, constant: 10),
            clearButton.topAnchor.constraint(equalTo: answerInputTextField.topAnchor),
            clearButton.leftAnchor.constraint(equalTo: submitButton.rightAnchor, constant: 10),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWordsFromFile()
        setupQuiz()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutAlphabetButton()
    }
    
    func layoutAlphabetButton() {
        let COLUMN = 4
        let ROW = 7
        let buttonWidth = Int(alphabetButtonsView.frame.width) / COLUMN
        let buttonHeight = Int(alphabetButtonsView.frame.height) / ROW
        
        for (index, button) in alphabetButtons.enumerated() {
            
            let buttonColumn = index % COLUMN
            let buttonRow = index / COLUMN
            button.frame = CGRect(x: buttonColumn * buttonWidth,
                                  y: buttonRow * buttonHeight,
                                  width: buttonWidth,
                                  height: buttonHeight)
            alphabetButtonsView.addSubview(button)
        }
    }
    
    func fetchWordsFromFile() {
        guard
            let url = Bundle.main.url(forResource: "words", withExtension: "txt"),
            let words = try? String(contentsOf: url)
        else {
            return
        }
        wordList += words.components(separatedBy: "\n").filter({ $0 != "" })
    }
    
    func setupQuiz() {
        answer = wordList.randomElement()!
        quizWordLabel.text = createHiddenAnswer()
        answerInputTextField.text = ""
        life = 7
        alphabetButtons.forEach { button in
            button.isEnabled = true
        }
    }
    
    func createHiddenAnswer() -> String {
        let hiddenAnswer = answer.map { _ in "_" }.joined(separator: " ")
        
        print("answer : ", answer," // hiddenAnswer : ", hiddenAnswer) // Debug
        return hiddenAnswer
    }
    
    @objc func checkAlphabet(_ sender: UIButton) {
        guard let alphabet = sender.titleLabel?.text else { return }
        sender.isEnabled = false // 1회만 button click 가능하게
        
        quizWordLabel.text = updateHiddenAnswer(alphabet: alphabet)
        
        if quizWordLabel.text?.replacingOccurrences(of: " ", with: "") == answer {
            showWinAlert()
            return
        }
        
        updateLife()
        
    }
    
    func updateHiddenAnswer(alphabet: String) -> String {
        guard let hiddenAnswer = quizWordLabel.text else { fatalError("answer have no string") }
        
        if answer.contains(alphabet) {
            var hiddenAnswerArray = hiddenAnswer.components(separatedBy: " ")
            var containedAlphabetIndex: [Int] = []
            
            for (index, letter) in answer.enumerated() {
                if String(letter) == alphabet {
                    containedAlphabetIndex.append(index)
                }
            }
            containedAlphabetIndex.forEach { hiddenAnswerArray[$0] = alphabet }
            
            return hiddenAnswerArray.joined(separator: " ")
            
        }
        return hiddenAnswer
    }
    
    func updateLife() {
        life -= 1
        
        if life <= 0 {
            showLoseAlert()
        }
    }
    
    @objc func tappedSubmitButton() {
        guard
            let inputtedAnswer = answerInputTextField.text?.lowercased(),
            !inputtedAnswer.isEmpty
        else { return }
        
        if inputtedAnswer == answer {
            showWinAlert()
            return
        }
        updateLife()
        answerInputTextField.text = ""
    }
    
    @objc func tappedClearButton() {
        answerInputTextField.text = ""
    }
    
    @objc func tappedResetButton() {
        setupQuiz()
    }
    
    func showWinAlert() {
        let alertController = UIAlertController(title: "Win!",
                                                message: nil,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Next",
                                                style: .default,
                                                handler: { [weak self] _ in
                                                    self?.setupQuiz()
                                                }))
        present(alertController, animated: true)
    }
    
    func showLoseAlert() {
        let alertController = UIAlertController(title: "Lose!",
                                                message: nil,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Try again",
                                                style: .default,
                                                handler: { [weak self] _ in
                                                    self?.setupQuiz()
                                                }))
        present(alertController, animated: true)
        
    }
    
}

