//
//  GameScene.swift
//  Project14
//
//  Created by JEONGSEOB HONG on 2021/08/02.
//

import SpriteKit
import GameplayKit

enum Display {
    static let width = 1024
    static let height = 768
}

enum SettingOption {
    static let MAXRound = 20
}

class GameScene: SKScene {
    var slots = [WhackSlot]()
    var gameScore = GameScoreLabel(at: CGPoint(x: 8, y: 8))
    var score = 0 {
        didSet {
            gameScore.text = "Score: \(score)"
        }
    }
    var popupTime = 0.85
    var numRounds = 0
    
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "whackBackground")
        background.position = CGPoint(x: Display.width / 2, y: Display.height / 2)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        addChild(gameScore)
        
        for i in 0..<5 { createSlot(at: CGPoint(x:  100 + (i * 170), y: 410)) }
        for i in 0..<4 { createSlot(at: CGPoint(x:  180 + (i * 170), y: 320)) }
        for i in 0..<5 { createSlot(at: CGPoint(x:  100 + (i * 170), y: 230)) }
        for i in 0..<4 { createSlot(at: CGPoint(x:  180 + (i * 170), y: 140)) }
        
        startGame()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tappedNodes = nodes(at: location)
        
        for node in tappedNodes {
            guard let whackSlot = node.parent?.parent as? WhackSlot else { continue } // It gets the parent of the parent of the node, and typecasts it as a WhackSlot. This line is needed because the player has tapped the penguin sprite node, not the slot – we need to get the parent of the penguin, which is the crop node it sits inside, then get the parent of the crop node, which is the WhackSlot object, which is what this code does.
            
            if !whackSlot.isVisible { continue }
            if whackSlot.isHit { continue }
            
            whackSlot.hit()
            
            if node.name == "charFriend" {
                // they shouldn't have whacked this penguin
                score -= 5
                
                run(SKAction.playSoundFileNamed("whackBad.caf", waitForCompletion: false))
            } else if node.name == "charEnemy" {
                // they should have whacked this one
                whackSlot.charNode.xScale = 0.85
                whackSlot.charNode.yScale = 0.85
                
                score += 1
                
                run(SKAction.playSoundFileNamed("whack.caf", waitForCompletion: false))
            }
        }
    }
    
    func startGame() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.createEnemy()
        }
    }
    
    func createSlot(at position: CGPoint) {
        let slot = WhackSlot()
        slot.configure(at: position)
        addChild(slot)
        
        slots.append(slot)
    }
    
    func createEnemy() {
        numRounds += 1
        if numRounds >= SettingOption.MAXRound {
            for slot in slots {
                slot.hide()
            }
            
            let gameOver = SKSpriteNode(imageNamed: "gameOver")
            gameOver.position = CGPoint(x: 512, y: 384)
            gameOver.zPosition = 1
            run(SKAction.playSoundFileNamed("gameOver.m4a", waitForCompletion: false))
            addChild(gameOver)
            
            let finalScoreLabel = FinalScoreLabel()
            finalScoreLabel.text = "Final Score: \(score)"
            addChild(finalScoreLabel)
            
            return
        }
        popupTime *= 0.991
        
        slots.shuffle()
        slots[0].show(hideTime: popupTime)
        
        if Int.random(in: 0...12) > 4 { slots[1].show(hideTime: popupTime) }
        if Int.random(in: 0...12) > 8 { slots[2].show(hideTime: popupTime) }
        if Int.random(in: 0...12) > 10 { slots[3].show(hideTime: popupTime) }
        if Int.random(in: 0...12) > 11 { slots[4].show(hideTime: popupTime) }
        
        let minDelay = popupTime / 2.0
        let maxDelay = popupTime * 2
        let delay = Double.random(in: minDelay...maxDelay)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.createEnemy()
        }
    }
    
}
