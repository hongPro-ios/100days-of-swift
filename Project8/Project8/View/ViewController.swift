//
//  ViewController.swift
//  Project8
//
//  Created by JEONGSEOB HONG on 2021/07/14.
//

import UIKit

class ViewController: UIViewController {
    enum LetterButton {
        static let width = 150
        static let height = 80
        static let row = 4
        static let column = 5
    }
    
    var scoreLabel = ScoreLabel()
    var cluesLabel = CluesLabel()
    var answersLabel = AnswersLabel()

    var currentAnswer: UITextField = {
        let currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = .systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false
        return currentAnswer
    }()
    var submitButton: UIButton = {
        let submitButton = UIButton(type: .system)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle("SUBMIT", for: .normal)
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        return submitButton
    }()
    
    var clearButton: UIButton = {
        let clearButton = UIButton(type: .system)
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.setTitle("CLEAR", for: .normal)
        clearButton.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        return clearButton
    }()
    var letterButtonsView: UIView = {
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        return buttonsView
    }()
    
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    var correctedSolutions = [String]()
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var level = 1
    var letterBits = [String]()
    
    override func loadView() {
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLevel()
    }
    
    func setupUI() {
        view = UIView()
        view.backgroundColor = .white
        
        view.addSubview(scoreLabel)
        view.addSubview(cluesLabel)
        view.addSubview(answersLabel)
        view.addSubview(currentAnswer)
        view.addSubview(submitButton)
        view.addSubview(clearButton)
        view.addSubview(letterButtonsView)
        
        setupConstraints()
        setupLetterButtons()

    }
    
    func setupConstraints() {
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
            
            letterButtonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            letterButtonsView.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 20),
            letterButtonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            letterButtonsView.widthAnchor.constraint(equalToConstant: 750),
            letterButtonsView.heightAnchor.constraint(equalToConstant: 320)
        ])
    }
    
    func setupLetterButtons() {
        for row in 0..<LetterButton.row {
            for column in 0..<LetterButton.column {
                let letterButton = createLetterButton(column: column, row: row)
                letterButtonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
            }
        }
    }
    
    func createLetterButton(column: Int, row: Int) -> UIButton {
        let letterButton = UIButton(type: .system)
        letterButton.titleLabel?.font = .systemFont(ofSize: 36)
        letterButton.setTitle("empty", for: .normal)
        letterButton.layer.borderWidth = 1
        letterButton.layer.borderColor = UIColor.lightGray.cgColor
        letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
        let frame = CGRect(x: column * LetterButton.width,
                           y: row *  LetterButton.height,
                           width:  LetterButton.width,
                           height:  LetterButton.height)
        letterButton.frame = frame
        return letterButton
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
        activatedButtons.append(sender)

        UIView.animate(withDuration: 0.5) {
            sender.alpha = 0.2
            sender.isEnabled = false
        }

    }
    
    @objc func submitTapped(_ sender: UIButton) {
        guard let answerText = currentAnswer.text else { return }
        guard let solutionPosition = solutions.firstIndex(of: answerText) else {
            showIncorrectAlert()
            clearCurrentInputAnswerAndActivatedButtonRevert()
            score -= 1
            return
        }
        
        var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
        splitAnswers?[solutionPosition] = answerText
        answersLabel.text = splitAnswers?.joined(separator: "\n")
        
        clearCurrentInputAnswer()
        score += 1
        
        correctedSolutions.append(answerText)
        
        if correctedSolutions.count == 7 {
            showNextLevelAlert()
        }
    }
    
    @objc func clearTapped(_ sender: UIButton) {
        clearCurrentInputAnswerAndActivatedButtonRevert()
    }
    
    func clearCurrentInputAnswerAndActivatedButtonRevert() {
        activatedButtons.forEach {
            $0.alpha = 1
            $0.isEnabled = true
        }
        clearCurrentInputAnswer()
    }
    
    func clearCurrentInputAnswer() {
        activatedButtons.removeAll()
        currentAnswer.text = ""
    }
    
    func showIncorrectAlert() {
        let alertController = UIAlertController(
            title: "Incorrect!!",
            message: nil,
            preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss",
                                                style: .cancel))
        
        present(alertController, animated: true)
    }
    
    func showNextLevelAlert() {
        let alertController = UIAlertController(
            title: "Well done!",
            message: "Are you ready for the next level?",
            preferredStyle: .alert)
        alertController.addAction(UIAlertAction(
                                    title: "Let's go!",
                                    style: .default,
                                    handler: levelUp))
        
        present(alertController, animated: true)
    }
    
    func levelUp(alertAction: UIAlertAction) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.level += 1
            
            self?.solutions.removeAll(keepingCapacity: true)
            DispatchQueue.main.async {
                self?.letterButtons.forEach { $0.isHidden = false }
            }
            
            self?.loadLevel()
        }
    }
    
    func loadLevel() {
        guard
            let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt"),
            let levelContents = try? String(contentsOf: levelFileURL)
        else { return }
        
        shuffleClue(levelContents: levelContents)
        shuffleLetterButtons()
    }
    
    func shuffleClue(levelContents: String) {
        var clueString = ""
        var answersString = ""
        var lines = levelContents.components(separatedBy: "\n")
        letterBits.removeAll()
        
        lines.shuffle()
        
        for (index, line) in lines.enumerated() {
            let parts = line.components(separatedBy: ": ")
            let answerIncludedPipeSymbol = parts[0]
            let clue = parts[1]
            
            clueString += "\(index + 1). \(clue)\n"
            
            let answerExcludedPipeSymbol = answerIncludedPipeSymbol.replacingOccurrences(of: "|", with: "")
            solutions.append(answerExcludedPipeSymbol)
            answersString += "\(answerExcludedPipeSymbol.count) letters\n"
            
            let answerLetterBits = answerIncludedPipeSymbol.components(separatedBy: "|")
            letterBits += answerLetterBits
        }
        DispatchQueue.main.async { [weak self] in
            self?.cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
            self?.answersLabel.text = answersString.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    
    func shuffleLetterButtons() {
        letterButtons.shuffle()

        if letterButtons.count == letterBits.count {
            for i in 0..<letterButtons.count {
                DispatchQueue.main.async { [weak self] in
                    self?.letterButtons[i].setTitle(self?.letterBits[i], for: .normal)
                }
            }
        } else {
            fatalError("level\(level)에 답이되는 word 갯수에 문제가 있다오 딱 20개가 되야 하는데 그걸 만족 못하고있다.")
        }
    }
}

