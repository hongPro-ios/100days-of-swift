//
//  ViewController.swift
//  Project5
//
//  Created by JEONGSEOB HONG on 2021/07/05.
//

import UIKit

enum ValidationError: Error {
    case useSellingOutOfBounds
    case notOriginal
    case notRealWord
    case etc
    
    var title: String {
        switch self {
        case .useSellingOutOfBounds:
            return "Word not possible"
        case .notOriginal:
            return "Word used already"
        case .notRealWord:
            return "Word not recognized"
        case .etc:
            return "etc"
        }
    }
    
    var message: String {
        switch self {
        case .useSellingOutOfBounds:
            return "You can't spell that word from"
        case .notOriginal:
            return "Be more original!"
        case .notRealWord:
            return "You can't just make them up, you know!"
        case .etc:
            return "etc"
        }
    }
}

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(promptForAnswer))
        
        guard
            let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"),
            let startWords = try? String(contentsOf: startWordsURL)
        else {
            return
        }
        
        allWords = startWords.components(separatedBy: "\n")
        startGame()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
        
    }
    
    func submit(_ answer: String) {
        let lowercasedAnswer = answer.lowercased()
        
        if validateWord(answer: lowercasedAnswer) {
            usedWords.insert(answer, at: 0)
            
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    func validateWord(answer: String) -> Bool {
        do {
            try isPossible(word: answer)
            try isOriginal(word: answer)
            try isReal(word: answer)
        
            return true
        } catch let validationError as ValidationError {
            let ac = UIAlertController(title: validationError.title, message: validationError.message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            
            return false
        } catch {
            return false
        }
    }
    
    @objc func promptForAnswer() {
        let alertController = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak alertController] _ in
            guard let answer = alertController?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        alertController.addTextField()
        alertController.addAction(submitAction)
        
        alertController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(alertController, animated: true)
    }
   
    func isPossible(word: String) throws  {
        guard var tempWord = title?.lowercased() else { throw ValidationError.etc }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                throw ValidationError.useSellingOutOfBounds
            }
        }
        
    }
    
    func isOriginal(word: String) throws {
        if usedWords.contains(word) {
            throw ValidationError.notOriginal
        }
    }
    
    func isReal(word: String) throws {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word,
            range: range,
            startingAt: 0,
            wrap: false,
            language: "en")
        if !(misspelledRange.location == NSNotFound) {
            throw ValidationError.notRealWord
        }
        
    }
    
}

