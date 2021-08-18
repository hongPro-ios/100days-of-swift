//
//  GameScene.swift
//  Project20
//
//  Created by JEONGSEOB HONG on 2021/08/17.
//

import SpriteKit


class GameScene: SKScene {
    let leftEdge = -22
    let bottomEdge = -22
    let rightEdge = DeviceSize.width + 22
    let maxLaunchCount = 4
    
    var gameTimer: Timer?
    var fireworks = [SKNode]()
    var scoreLabel: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var launchCountLabel: SKLabelNode!
    var launchCount = 0 {
        didSet {
            launchCountLabel.text = "Left launch: \(maxLaunchCount - launchCount)"
        }
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        
        background.position = CGPoint(x: DeviceSize.centerXPosition, y: DeviceSize.centerYPosition)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        gameTimer = Timer.scheduledTimer(timeInterval: 6,
                                         target: self,
                                         selector: #selector(launchFireWorks),
                                         userInfo: nil,
                                         repeats: true)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkboard SE")
        scoreLabel.position = CGPoint(x: DeviceSize.centerXPosition, y: DeviceSize.height - 40)
        scoreLabel.text = "Score: \(score)"
        scoreLabel.fontSize = 40
        addChild(scoreLabel)
        
        launchCountLabel = SKLabelNode(fontNamed: "Chalkboard SE")
        launchCountLabel.position = CGPoint(x: DeviceSize.width - 160, y: DeviceSize.height - 40)
        launchCountLabel.text = "Left launch: \(maxLaunchCount)"
        launchCountLabel.fontSize = 40
        addChild(launchCountLabel)
        
    }
    
    
    @objc func launchFireWorks() {
        if maxLaunchCount <= launchCount {
            gameTimer?.invalidate()
            
            let endLabel = SKLabelNode(fontNamed: "Chalkboard SE")
            endLabel.position = CGPoint(x: DeviceSize.centerXPosition, y: DeviceSize.centerYPosition)
            endLabel.text = "End!!"
            endLabel.fontSize = 40
            addChild(endLabel)
            
            return
        }
        
        let movementAmount: CGFloat = 1800
        
        switch Int.random(in: 0...3) {
        case 0:
            // fire five, straight up
            createFirework(xMovement: 0, x: DeviceSize.centerXPosition, y: bottomEdge)
            createFirework(xMovement: 0, x: DeviceSize.centerXPosition - 200, y: bottomEdge)
            createFirework(xMovement: 0, x: DeviceSize.centerXPosition - 100, y: bottomEdge)
            createFirework(xMovement: 0, x: DeviceSize.centerXPosition + 100, y: bottomEdge)
            createFirework(xMovement: 0, x: DeviceSize.centerXPosition + 200, y: bottomEdge)
        case 1:
            // fire five,in a fan
            createFirework(xMovement: 0, x: DeviceSize.centerXPosition, y: bottomEdge)
            createFirework(xMovement: -200, x: DeviceSize.centerXPosition - 200, y: bottomEdge)
            createFirework(xMovement: -100, x: DeviceSize.centerXPosition - 100, y: bottomEdge)
            createFirework(xMovement: 100, x: DeviceSize.centerXPosition + 100, y: bottomEdge)
            createFirework(xMovement: 200, x: DeviceSize.centerXPosition + 200, y: bottomEdge)
        case 2:
            // fire five, from the left to the right
            createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 400)
            createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 300)
            createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 200)
            createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 100)
            createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge)
        case 3:
            // fire five, from the right to the left
            createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 400)
            createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 300)
            createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 200)
            createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 100)
            createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge)
        default:
            break
        }
        
        launchCount += 1
    }
    
    func createFirework(xMovement: CGFloat, x: Int, y: Int) {
        let node = SKNode()
        node.position = CGPoint(x: x, y: y)
        
        let firework = SKSpriteNode(imageNamed: "rocket")
        firework.colorBlendFactor = 1
        firework.name = "firework"
        node.addChild(firework)
        
        switch Int.random(in: 0...2) {
        case 0:
            firework.color = .cyan
        case 1:
            firework.color = .green
        default:
            firework.color = .red
        }
        
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: xMovement, y: 1000))
        
        let move = SKAction.follow(path.cgPath,
                                   asOffset: true,
                                   orientToPath: true,
                                   speed: 200)
        node.run(move)
        
        if let emitter = SKEmitterNode(fileNamed: "fuse") {
            emitter.position = CGPoint(x: 0, y: -22)
            node.addChild(emitter)
        }
        
        fireworks.append(node)
        addChild(node)
    }
    
    func checkTouches(_ touches: Set<UITouch>) {
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)
        
        for case let selectedNode as SKSpriteNode in nodesAtPoint {
            guard selectedNode.name == "firework" else { continue }
            
            for parent in fireworks {
                guard let firework = parent.children.first as? SKSpriteNode else { continue }
                if firework.name == "selected" && firework.color != selectedNode.color {
                    firework.name = "firework"
                    firework.colorBlendFactor = 1
                }
            }
            selectedNode.name = "selected"
            selectedNode.colorBlendFactor = 0
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        checkTouches(touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        checkTouches(touches)
    }
    
    override func update(_ currentTime: TimeInterval) {
        for (index, firework) in fireworks.enumerated().reversed() {
            if firework.position.y > 900 {
                fireworks.remove(at: index)
                firework.removeFromParent()
            }
        }
    }
    
    func explode(firework: SKNode) {
        let emitter = SKEmitterNode(fileNamed: "explode")!
        emitter.position = firework.position
        addChild(emitter)
        
        let waitForEmitterFinish = SKAction.wait(forDuration: 0.1)
        let deleteFirework = SKAction.run { firework.removeFromParent() }
        let sequence = SKAction.sequence([waitForEmitterFinish, deleteFirework])
        emitter.run(sequence)
        
    }
    
    func explodeFireworks() {
        var numExploded = 0
        
        for (index, fireworkContainer) in fireworks.enumerated().reversed() {
            guard let firework = fireworkContainer.children.first as? SKSpriteNode else { return }
            
            if firework.name == "selected" {
                explode(firework: fireworkContainer)
                fireworks.remove(at: index)
                numExploded += 1
            }
        }
        
        switch numExploded {
        case 0:
            break
        case 1:
            score += 200
        case 2:
            score += 500
        case 3:
            score += 1500
        case 4:
            score += 2500
        default:
            score += 4000
        }
        
    }
}
