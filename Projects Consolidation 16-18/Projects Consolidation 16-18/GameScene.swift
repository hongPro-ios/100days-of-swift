//
//  GameScene.swift
//  Projects Consolidation 16-18
//
//  Created by JEONGSEOB HONG on 2021/08/13.
//

import SpriteKit
import GameplayKit

enum Device {
    static let width: Int = 1366
    static let height: Int = 1024
    static let xCenter: Int =  width / 2
    static let yCenter: Int =  height / 2
    
}

class GameScene: SKScene {
    var scoreLabel: SKLabelNode!
    var timeLabel: SKLabelNode!
    var leftBulletLabel: SKLabelNode!
    
    
    override func didMove(to view: SKView) {
        backgroundColor = .brown
        
        let backgroundSpriteNode = SKSpriteNode(imageNamed: "galleryGameBackground")
        backgroundSpriteNode.position = CGPoint(x: Device.xCenter, y: Device.yCenter)
        backgroundSpriteNode.zPosition = -1
        backgroundSpriteNode.blendMode = .replace
        addChild(backgroundSpriteNode)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 100, y: Device.height - 100)
        scoreLabel.text = "scoreLabel"
        scoreLabel.fontSize = 20
        addChild(scoreLabel)
        
        timeLabel = SKLabelNode(fontNamed: "Chalkduster")
        timeLabel.position = CGPoint(x: Device.xCenter, y: Device.height - 100)
        timeLabel.text = "timeLabel"
        timeLabel.fontSize = 20
        addChild(timeLabel)
        
        leftBulletLabel = SKLabelNode(fontNamed: "Chalkduster")
        leftBulletLabel.position = CGPoint(x: Device.width - 100, y: Device.height - 100)
        leftBulletLabel.text = "leftBulletLabel"
        leftBulletLabel.fontSize = 20
        addChild(leftBulletLabel)
        
        managerTarget()

        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
    }
    
    func managerTarget() {
        Timer.scheduledTimer(timeInterval: 1,
                             target: self,
                             selector: #selector(createTarget),
                             userInfo: nil,
                             repeats: true)
    }
    
    @objc func createTarget() {
        print("target created")
        let targetNameList = ["dolphin", "seahorse", "stingRay", "turtle"]
        let targetNode = SKSpriteNode(imageNamed: targetNameList.randomElement()!)
        targetNode.position = CGPoint(x: Device.width + 100,
                                      y: Device.height - 200)
        targetNode.size = .init(width: 100, height: 100)
        
        targetNode.physicsBody = SKPhysicsBody(rectangleOf: targetNode.size)
        targetNode.physicsBody?.velocity = CGVector(dx: Int.random(in: (-500)...(-100)), dy: 0)
        targetNode.physicsBody?.linearDamping = 0
        
        addChild(targetNode)
    }
    
    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if node.position.x < -300 {
                node.removeFromParent()
            }
        }
    }
   
}


