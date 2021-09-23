//
//  ViewController.swift
//  Projects Consolidation 28-30
//
//  Created by JEONGSEOB HONG on 2021/09/23.
//

import UIKit

class Card: UIButton {
    var width = 50
    var height = 70
    var isPaired = false
    var index: Int = 0
}

class ViewController: UIViewController {
    var indexes = [1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8].shuffled()
    
    let rows = 4
    let cols = 4
    
    var cards: [Card] = []
    
    var checkingCardList: [Card] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCard()
    }
    
    func setupCard() {
        for row in 1...rows {
            for col in 1...cols {
                let card = Card(type: .system)
                card.index = indexes.popLast() ?? 0
                card.frame = CGRect(x: (card.width + 20) * col,
                                    y: (card.height + 20) * row,
                                    width: card.width,
                                    height: card.height)
                card.backgroundColor = .red
                card.addTarget(self, action: #selector(touchedCard), for: .touchUpInside)
                
                cards.append(card)
                
                view.addSubview(card)
            }
        }
    }
    
    @objc func touchedCard(sender: UIButton) {
        guard let card = sender as? Card else { return }
        
        // push checking card array
        if self.checkingCardList.count < 3 {
            self.checkingCardList.append(card)
        }
        
        
        // show up back of card
        UIView.transition(with: card, duration: 0.5, options: [.transitionFlipFromRight]) {
            card.setTitle("\(card.index)", for: .normal)
            card.backgroundColor = .yellow
        } completion: { [self] completed in
            guard completed == true else { return }
            if !checkingCardList.contains(card) {
                UIView.transition(with: card, duration: 0.5, options: [.transitionFlipFromRight]) {
                    card.setTitle("", for: .normal)
                    card.backgroundColor = .red
                }
            } else {
                isPairCard()
            }
        }
        
        self.checkGame()
        
    }
    
    func isPairCard() {
        // if correct:
        if checkingCardList[0].index == checkingCardList[1].index {
            checkingCardList.forEach { card in
                UIView.animate(withDuration: 1) {
                    card.alpha = 0
                }
            }
        } else {
            checkingCardList.forEach { card in
                UIView.transition(with: card, duration: 1.0, options: [.transitionFlipFromRight]) {
                    card.setTitle("", for: .normal)
                    card.backgroundColor = .red
                } completion: { completed in
                    if completed {
                        //remove checkingCardList elements
                        self.checkingCardList.removeAll()
                    }
                    
                }
            }
        }
        
    }
    
    func checkGame() {
        if cards.allSatisfy({ card in card.isPaired == true }) {
            print("End Game")
        }
    }
    
}

