//
//  GameScene.swift
//  Project26
//
//  Created by JEONGSEOB HONG on 2021/09/03.
//

import CoreMotion
import SpriteKit
import GameplayKit

enum CollisionTypes: UInt32 {
    case player = 1
    case wall = 2
    case star = 4
    case vortex = 8
    case finish = 16
    case teleport = 32
}

class GameScene: SKScene {
    var isGameOver = false
    var player: SKSpriteNode!
    var lastTouchPosition: CGPoint?
    
    var motionManager: CMMotionManager?
    
    var scoreLabel: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
        motionManager = CMMotionManager()
        motionManager?.startAccelerometerUpdates()
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        let background = SKSpriteNode(imageNamed: "background")
        background.name = "background"
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.name = "scoreLabel"
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.text = "Score: 0"
        scoreLabel.zPosition = 2
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)
        
        loadLevel()
        createPlayer()
    }
    
    func loadLevel(level: Int = 1) {
        guard let levelURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") else { fatalError("loading level\(level).txt Error") }
        guard let levelString = try? String(contentsOf: levelURL) else { fatalError("loading level1(level).txt Error") }
        
        let lines = levelString.components(separatedBy: "\n").filter { !($0.count == 0) }
        
        for (row, line) in lines.reversed().enumerated() {
            for (column, letter) in line.enumerated() {
                let position = CGPoint(x: (64 * column) + 32, y: (64 * row) + 32)
                addNode(string: letter, position: position)
            }
        }
    }
    
    func addNode(string letter: String.Element, position: CGPoint) {
        switch letter {
        case "x":
            let node = BlockSpriteNode(imageName: "block", position: position)
            addChild(node)
            break
        case "v":
            let node = VortexSpriteNode(imageName: "vortex", position: position)
            addChild(node)
            break
        case "s":
            let node = StarSpriteNode(imageName: "star", position: position)
            addChild(node)
            break
        case "f":
            let node = FinishSpriteNode(imageName: "finish", position: position)
            addChild(node)
            break
        case "t":
            let node = TeleportSpriteNode(imageName: "teleport", position: position)
            addChild(node)
            break
        case " ":
            break
        default:
            fatalError()
        }
    }
    
    func createPlayer(position: CGPoint = CGPoint(x: 96, y: 672)) {
        player = SKSpriteNode(imageNamed: "player")
        player.position = position
        //        player.position = CGPoint(x: 1024 - 64, y: 64)
        player.zPosition = 1
        
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2)
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.linearDamping = 0.5
        
        player.physicsBody?.categoryBitMask = CollisionTypes.player.rawValue
        player.physicsBody?.contactTestBitMask = CollisionTypes.star.rawValue
            | CollisionTypes.finish.rawValue
            | CollisionTypes.vortex.rawValue
            | CollisionTypes.teleport.rawValue
        player.physicsBody?.collisionBitMask = CollisionTypes.wall.rawValue
        addChild(player)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        lastTouchPosition = location
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        lastTouchPosition = location
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchPosition = nil
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard isGameOver == false else { return }
        #if targetEnvironment(simulator)
        if let lastTouchPosition = lastTouchPosition {
            let diff = CGPoint(x: lastTouchPosition.x - player.position.x,
                               y: lastTouchPosition.y - player.position.y)
            physicsWorld.gravity = CGVector(dx: diff.x / 100, dy: diff.y / 100)
        }
        #else
        if let accelerometerData = motionManager?.accelerometerData {
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -50,
                                            dy: accelerometerData.acceleration.x * 50)
        }
        #endif
    }
    
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        if nodeA == player {
            playerCollided(with: nodeB)
        } else if nodeB == player {
            playerCollided(with: nodeA)
        }
    }
    
    func playerCollided(with node: SKNode) {
        if node.name == "vortex" {
            player.physicsBody?.isDynamic = false
            isGameOver = true
            score -= 1
            let move = SKAction.move(to: node.position, duration: 0.25)
            let scale = SKAction.scale(to: 0.0001, duration: 0.25)
            let remove = SKAction.removeFromParent()
            
            let sequence = SKAction.sequence([move, scale, remove])
            
            player.run(sequence) { [weak self] in
                self?.createPlayer()
                self?.isGameOver = false
            }
        } else if node.name == "star" {
            score += 1
            
            let scale = SKAction.scale(by: 0.0001, duration: 0.5)
            let rotate = SKAction.rotate(toAngle: .pi, duration: 0.5)
            let fadeOut = SKAction.fadeOut(withDuration: 0.5)
            let group = SKAction.group([scale, rotate, fadeOut])
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([group, remove])
            
            node.run(sequence)
            
        } else if node.name == "teleport" {
            score += 1
            
            let scale = SKAction.scale(by: 0.0001, duration: 0.5)
            let rotate = SKAction.rotate(toAngle: .pi, duration: 0.5)
            let fadeOut = SKAction.fadeOut(withDuration: 0.5)
            let group = SKAction.group([scale, rotate, fadeOut])
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([group, remove])
            
            player.run(sequence) { [weak self] in
                self?.createPlayer(position: CGPoint(x: 1024 - 64, y: 64))
            }
            
        }
        
        else if node.name == "finish" {
            // next level
            score = 0
            
            clearNode()
            loadLevel(level: 2)
            createPlayer()
            
        }
    }
    
    func clearNode() {
        // Removing Specific Children
        for child in self.children {
            //Determine Details
            if !(child.name == "background" || child.name == "scoreLabel") {
                child.removeFromParent()
            }
            
        }
    }
}
