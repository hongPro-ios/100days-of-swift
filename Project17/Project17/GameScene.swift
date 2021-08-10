//
//  GameScene.swift
//  Project17
//
//  Created by JEONGSEOB HONG on 2021/08/09.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var starField: SKEmitterNode!
    var player: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var possibleEnemies = ["ball", "hammer", "tv"]
    var gameTimer: Timer?
    var isGameOver = false
    var createdEnemyCount: Int = 0
    var enemyCreatingTimeInterval: TimeInterval = 1
    
    override func didMove(to view: SKView) {
        setup()
        startGame()
    }
    
    func setup() {
        backgroundColor = .black
        
        starField = SKEmitterNode(fileNamed: "starField")
        starField.position = CGPoint(x: 1024, y: 384)
        starField.advanceSimulationTime(10)
        starField.zPosition = -1
        addChild(starField)
        
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 100, y: 384)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.contactTestBitMask = 1
        addChild(player)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
    }
    
    func startGame() {
        score = 0
        gameTimer = Timer.scheduledTimer(timeInterval: enemyCreatingTimeInterval,
                                         target: self,
                                         selector: #selector(manageEnemy),
                                         userInfo: nil,
                                         repeats: true)
    }
    
    @objc func manageEnemy() {
        if createdEnemyCount > 20 {
            // reset gameTimer
            // 0. reset property(enemiesCount)
            createdEnemyCount = 0
            enemyCreatingTimeInterval -= 0.1
            if enemyCreatingTimeInterval < 0.5 {
                // TBD: go to next level game
                print("enemyCreatingTimeInterval < 0.5")
                return
            }
            
            // 1. gameTimer clear by gameTimer?.invalidate()
            gameTimer?.invalidate()
            // 2. create new gamiTimer
            gameTimer = Timer.scheduledTimer(timeInterval: enemyCreatingTimeInterval,
                                             target: self,
                                             selector: #selector(manageEnemy),
                                             userInfo: nil,
                                             repeats: true)
            
        } else {
            // create enemy
            createEnemy()
        }
    }
    
    func createEnemy() {
        guard let enemyImageName = possibleEnemies.randomElement() else { return }
        
        let enemy = SKSpriteNode(imageNamed: enemyImageName)
        enemy.position = CGPoint(x: 1200, y: Int.random(in: 50...736))
        addChild(enemy)
        
        enemy.physicsBody = SKPhysicsBody(texture: enemy.texture!, size: enemy.size)
        enemy.physicsBody?.categoryBitMask = 1
        enemy.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
        enemy.physicsBody?.linearDamping = 0
        enemy.physicsBody?.angularVelocity = 5
        enemy.physicsBody?.angularDamping = 0
        
        createdEnemyCount += 1
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if node.position.x < -300 {
                node.removeFromParent()
            }
        }
        
        if !isGameOver {
            score += 1
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        var location = touch.location(in: self)
    
        
        if location.y < 100 {
            location.y = 100
        } else if location.y > 668 {
            location.y = 668
        }
        
        player.position = location
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        collisionEffect()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        collisionEffect()
    }
    
    func collisionEffect() {
        if children.contains(player) {
            let explosion = SKEmitterNode(fileNamed: "explosion")!
            explosion.position = player.position
            addChild(explosion)
            
            player.removeFromParent()
            isGameOver = true
            gameTimer?.invalidate()
        } else {
            return
        }
    }
}
