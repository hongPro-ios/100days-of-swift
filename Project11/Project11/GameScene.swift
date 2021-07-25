//
//  GameScene.swift
//  Project11
//
//  Created by JEONGSEOB HONG on 2021/07/23.
//

import SpriteKit

enum BallType: String, CaseIterable {
    case blue = "Blue"
    case cyan = "Cyan"
    case green = "Green"
    case grey = "Grey"
    case purple = "Purple"
    case red = "Red"
    case yellow = "Yellow"
}

class GameScene: SKScene {
    var scoreLabel: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var editLabel: SKLabelNode!
    var editingMode: Bool = false {
        didSet {
            editLabel.text = editingMode ? "Done" : "Edit"
            
        }
    }
    var leftBallCount: SKLabelNode!
    var leftBall = 5 {
        didSet {
            leftBallCount.text = "Ball: \(leftBall)"
        }
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 1024 / 2, y: 768 / 2)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)
        
        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)
        
        leftBallCount = SKLabelNode(fontNamed: "Chalkduster")
        leftBallCount.text = "Ball: 5"
        leftBallCount.position = CGPoint(x: 500, y: 700)
        addChild(leftBallCount)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        let positionBouncers: [CGPoint] = [.init(x: 0, y: 0),
                                           .init(x: 256, y: 0),
                                           .init(x: 512, y: 0),
                                           .init(x: 768, y: 0),
                                           .init(x: 1024, y: 0),
        ]
        positionBouncers.forEach { makeBouncer(at: $0) }
        
        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 386, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: self)
        let objects = nodes(at: location)
        
        if objects.contains(editLabel) {
            editingMode.toggle()
            return
        }
        
        editingMode ? makeObstacle(at: location) : makeBall(at: location)
    }
    
    func makeObstacle(at position: CGPoint) {
        let size = CGSize(width: Int.random(in: 16...128), height: 16)
        let obstacleColor = UIColor(red: CGFloat.random(in: 0...1),
                                    green: CGFloat.random(in: 0...1),
                                    blue: CGFloat.random(in: 0...1),
                                    alpha: 1)
        let obstacle = SKSpriteNode(color: obstacleColor, size: size)
        obstacle.name = "obstacle"
        obstacle.zRotation = CGFloat.random(in: 0...3)
        obstacle.position = position
        obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.size)
        obstacle.physicsBody?.isDynamic = false
        addChild(obstacle)
    }
    
    func makeBall(at position: CGPoint) {
        guard let ballType = BallType.allCases.randomElement() else { return }
        
        let ball = SKSpriteNode(imageNamed: "ball\(ballType.rawValue)")
        ball.name = "ball"
        ball.position = CGPoint(x: position.x, y: 768)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
        ball.physicsBody?.restitution = 0.4
        ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
        addChild(ball)
    }
    
    func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2)
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
    }
    
    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }
        
        slotBase.position = position
        slotGlow.position = position
        
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        
        addChild(slotBase)
        addChild(slotGlow)
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA.name == "ball" {
            collision(between: nodeA, object: nodeB)
        } else if nodeB.name == "ball" {
            collision(between: nodeB, object: nodeA)
        }
    }
    
    func collision(between ball: SKNode, object: SKNode) {
        if object.name == "good" {
            destroy(objectNode: ball)
            score += 1
            leftBall += 1
        } else if object.name == "bad" {
            destroy(objectNode: ball)
            score -= 1
            leftBall -= 1
        } else if object.name == "obstacle" {
            destroy(objectNode: object)
        }
    }
    
    func destroy(objectNode: SKNode) {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = objectNode.position
            addChild(fireParticles)
        }
        objectNode.removeFromParent()
    }
    
}
