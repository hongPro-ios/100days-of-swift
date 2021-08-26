//
//  GameScene.swift
//  Project23
//
//  Created by JEONGSEOB HONG on 2021/08/24.
//

import AVFoundation
import SpriteKit


class GameScene: SKScene {
    struct Constants {
        static let enemyStartXPositionMax: Int = 960
        static let enemyStartXPositionMin: Int = 64
        static let enemyStartYPositionMin: Int = -128
        static let enemyAngularVelocityMin: CGFloat = -3
        static let enemyAngularVelocityMax: CGFloat = 3
        static let enemyXVelocityMin = 3
        static let enemyXVelocity5 = 5
        static let enemyXVelocity8 = 8
        static let enemyXVelocityMax = 15
        static let enemyYVelocityMin = 24
        static let enemyYVelocityMax = 32
    }
    
    var bombSoundEffect: AVAudioPlayer?
    var gameScoreLabelNode: SKLabelNode!
    var activeSliceBG: SKShapeNode!
    var activeSliceFG: SKShapeNode!
    
    var score = 0 {
        didSet {
            gameScoreLabelNode.text = "Score: \(score)"
        }
    }
    var livesImages = [SKSpriteNode]()
    var lives = 3
    var activeSlicePoints = [CGPoint]()
    var isSwooshSoundActive = false
    var activeEnemies = [SKSpriteNode]()
    var popupTime = 0.9
    var sequence = [SequenceType]()
    var sequencePosition = 0
    var chainDelay = 3.0
    var nextSequenceQueued = true
    var isGameEnded = false
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "sliceBackground")
        background.position = CGPoint(x: Device.height / 2, y: Device.width / 2)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -6)
        physicsWorld.speed = 0.85
        
        createScore()
        createLives()
        createSlices()
        
        sequence = [.twoWithOneBomb, .oneNoBomb, .fastOne, .fastOne, .oneNoBomb, .twoWithOneBomb, .twoWithOneBomb, .three, .one, .chain]
        
        for _ in 0...1000 {
            if let nextSequence = SequenceType.allCases.randomElement() {
                sequence.append(nextSequence)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.tossEnemies()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isGameEnded == false else { return }
        
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        activeSlicePoints.append(location)
        redrawActiveSlice()
        
        let nodesAtPoint = nodes(at: location)
        
        for case let node as SKSpriteNode in nodesAtPoint {
            if node.name == "enemy" || node.name == "fastEnemy" {
                let isFastEnemy = node.name == "fastEnemy"
                
                if let emitter = SKEmitterNode(fileNamed: "sliceHitEnemy") {
                    emitter.position = node.position
                    addChild(emitter)
                }
                
                node.name = "" // 이 라인이 없으면 짧은 순간에 여러번 실행되어 버린다.
                node.physicsBody?.isDynamic = false
                
                let scaleOut = SKAction.scale(by: 0.001, duration: 0.2)
                let fadeOut = SKAction.fadeOut(withDuration: 0.2)
                let impactSound = SKAction.playSoundFileNamed("whack.caf", waitForCompletion: false)
                let group = SKAction.group([scaleOut, fadeOut, impactSound])
                
                let sequence = SKAction.sequence([group, .removeFromParent()])
                node.run(sequence)
                
                if isFastEnemy {
                    score += 10
                } else {
                    score += 1
                }
                if let index = activeEnemies.firstIndex(of: node) {
                    activeEnemies.remove(at: index)
                }
                
            } else if node.name == "bomb" {
                guard let bombContainer = node.parent as? SKSpriteNode else { continue }
                if let emitter = SKEmitterNode(fileNamed: "sliceHitBomb") {
                    emitter.position = bombContainer.position
                    addChild(emitter)
                }
                
                node.name = ""
                bombContainer.physicsBody?.isDynamic = false
                
                let scaleOut = SKAction.scale(by: 0.001, duration: 0.2)
                let fadeOut = SKAction.fadeOut(withDuration: 0.2)
                let impactSound = SKAction.playSoundFileNamed("explosion.caf", waitForCompletion: false)
                let group = SKAction.group([scaleOut, fadeOut, impactSound])
                let sequence = SKAction.sequence([group, .removeFromParent()])
                bombContainer.run(sequence)
                
                if let index = activeEnemies.firstIndex(of: bombContainer) {
                    activeEnemies.remove(at: index)
                }
                
                endGame(triggeredByBomb: true)
            }
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        activeSliceBG.run(SKAction.fadeOut(withDuration: 0.25))
        activeSliceFG.run(SKAction.fadeOut(withDuration: 0.25))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        activeSlicePoints.removeAll(keepingCapacity: true)
        
        let location = touch.location(in: self)
        activeSlicePoints.append(location)
        redrawActiveSlice()
        
        activeSliceBG.removeAllActions()
        activeSliceFG.removeAllActions()
        
        activeSliceBG.alpha = 1
        activeSliceFG.alpha = 1
        
        
        if !isSwooshSoundActive { playSwooshSound() }
        
    }
    
    func createScore() {
        gameScoreLabelNode = SKLabelNode(fontNamed: "Chalkduster")
        gameScoreLabelNode.position = CGPoint(x: 8, y: 8)
        gameScoreLabelNode.horizontalAlignmentMode = .left
        gameScoreLabelNode.fontSize = 48
        addChild(gameScoreLabelNode)
        
        score = 0
    }
    
    func createLives() {
        for i in 0 ..< 3 {
            let sliceLifeSpritNode = SKSpriteNode(imageNamed: "sliceLife")
            sliceLifeSpritNode.position = CGPoint(x: CGFloat(834 + (i * 70)), y: 720)
            addChild(sliceLifeSpritNode)
            livesImages.append(sliceLifeSpritNode)
        }
    }
    
    func createSlices() {
        activeSliceBG = SKShapeNode()
        activeSliceBG.zPosition = 2
        activeSliceBG.strokeColor = UIColor(red: 1, green: 0.9, blue: 0, alpha: 1)
        activeSliceBG.lineWidth = 9
        addChild(activeSliceBG)
        
        activeSliceFG = SKShapeNode()
        activeSliceFG.zPosition = 3
        activeSliceFG.strokeColor = UIColor.white
        activeSliceFG.lineWidth = 5
        addChild(activeSliceFG)
    }
    
    func redrawActiveSlice() {
        let maxNumberOfPointToKeepOnLine = 30
        
        if activeSlicePoints.count < 2 {
            activeSliceBG.path = nil
            activeSliceFG.path = nil
            return
        }
        
        if activeSlicePoints.count > maxNumberOfPointToKeepOnLine {
            activeSlicePoints.removeFirst(activeSlicePoints.count - maxNumberOfPointToKeepOnLine)
        }
        
        let path = UIBezierPath()
        path.move(to: activeSlicePoints[0])
        
        for i in 1 ..< activeSlicePoints.count {
            path.addLine(to: activeSlicePoints[i])
        }
        
        activeSliceBG.path = path.cgPath
        activeSliceFG.path = path.cgPath
    }
    
    func playSwooshSound() {
        isSwooshSoundActive = true
        
        let randomNumber = Int.random(in: 1...3)
        let soundName = "swoosh\(randomNumber).caf"
        
        let swooshSound = SKAction.playSoundFileNamed(soundName, waitForCompletion: true)
        run(swooshSound) { [weak self] in
            self?.isSwooshSoundActive = false
        }
    }
    
    func createEnemy(forceBomb: ForceBomb = .random, speed: Speed = .normal) {
        let enemy: SKSpriteNode
        
        var enemyType: EnemyType = [EnemyType.bomb,
                                    EnemyType.penguin,
                                    EnemyType.penguin,
                                    EnemyType.penguin,
                                    EnemyType.penguin,
                                    EnemyType.penguin].randomElement()!
        
        if forceBomb == .never {
            enemyType = .penguin
        } else if forceBomb == .always {
            enemyType = .bomb
        }
        
        if enemyType == .bomb {
            enemy = SKSpriteNode()
            enemy.zPosition = 1
            enemy.name = "bombContainer"
            
            let bombImage = SKSpriteNode(imageNamed: "sliceBomb")
            bombImage.name = "bomb"
            enemy.addChild(bombImage)
            
            if let emitter = SKEmitterNode(fileNamed: "sliceFuse") {
                emitter.position = CGPoint(x: 76, y: 64)
                enemy.addChild(emitter)
            }
            
            if bombSoundEffect != nil {
                bombSoundEffect?.stop()
                bombSoundEffect = nil
            }
            if let path = Bundle.main.url(forResource: "sliceBombFuse", withExtension: "caf") {
                if let sound = try? AVAudioPlayer(contentsOf: path) {
                    bombSoundEffect = sound
                    sound.play()
                }
            }
        } else {
            enemy = SKSpriteNode(imageNamed: "penguin")
            run(SKAction.playSoundFileNamed("launch.caf", waitForCompletion: false))
            enemy.name = "enemy"
            
            if speed == .fast {
                enemy.name = "fastEnemy"
            }
        }
        
        // position code goes here
        let randomPosition = CGPoint(x: Int.random(in: Constants.enemyStartXPositionMin...Constants.enemyStartXPositionMax),
                                     y: Constants.enemyStartYPositionMin)
        enemy.position = randomPosition
        
        let randomAngularVelocity = CGFloat.random(in: Constants.enemyAngularVelocityMin...Constants.enemyAngularVelocityMax)
        var randomXVelocity: Int
        
        if randomPosition.x < CGFloat(Device.width / 4) * 1 {
            randomXVelocity = Int.random(in: Constants.enemyXVelocity8...Constants.enemyXVelocityMax)
        } else if randomPosition.x < CGFloat(Device.width / 4) * 2 {
            randomXVelocity = Int.random(in: Constants.enemyXVelocityMin...Constants.enemyXVelocity5)
        } else if randomPosition.x < CGFloat(Device.width / 4) * 3 {
            randomXVelocity = -Int.random(in: Constants.enemyXVelocityMin...Constants.enemyXVelocity5)
        } else {
            randomXVelocity = -Int.random(in: Constants.enemyXVelocity8...Constants.enemyXVelocityMax)
        }
        
        var randomYVelocity = Int.random(in: Constants.enemyYVelocityMin...Constants.enemyYVelocityMax)
        
        if speed == .fast {
            randomXVelocity = Int(Double(Constants.enemyXVelocityMax) * 1.2)
            randomYVelocity = Int(Double(Constants.enemyYVelocityMax) * 1.2)
        }
        
        enemy.physicsBody = SKPhysicsBody(circleOfRadius: 64)
        enemy.physicsBody?.velocity = CGVector(dx: randomXVelocity * 40, dy: randomYVelocity * 40)
        enemy.physicsBody?.angularVelocity = randomAngularVelocity
        enemy.physicsBody?.collisionBitMask = 0
        
        addChild(enemy)
        activeEnemies.append(enemy)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if activeEnemies.count > 0 {
            for (index, node) in activeEnemies.enumerated().reversed() {
                if node.position.y < -140 {
                    node.removeAllActions()
                    
                    if node.name == "enemy" || node.name == "fastEnemy" {
                        subtractLife()
                        
                        node.name = ""
                        node.removeFromParent()
                        activeEnemies.remove(at: index)
                    } else if node.name == "bombContainer" {
                        node.name = ""
                        node.removeFromParent()
                        activeEnemies.remove(at: index)
                    }
                }
            }
        } else {
            if !nextSequenceQueued {
                DispatchQueue.main.asyncAfter(deadline: .now() + popupTime) {
                    [weak self] in
                    self?.tossEnemies()
                }
                
                nextSequenceQueued = true
            }
        }
        var bombCount = 0
        
        for node in activeEnemies {
            if node.name == "bombContainer" {
                bombCount += 1
                break
            }
        }
        
        if bombCount == 0 {
            bombSoundEffect?.stop()
            bombSoundEffect = nil
        }
    }
    
    func tossEnemies() {
        guard isGameEnded == false else { return }
        
        popupTime *= 0.991
        chainDelay *= 0.99
        physicsWorld.speed *= 1.02
        
        let sequenceType = sequence[sequencePosition]
        
        switch sequenceType {
        case .oneNoBomb:
            createEnemy(forceBomb:  .never)
        case .one:
            createEnemy()
        case .twoWithOneBomb:
            createEnemy(forceBomb:  .never)
            createEnemy(forceBomb:  .always)
        case .two:
            createEnemy()
            createEnemy()
        case .three:
            createEnemy()
            createEnemy()
            createEnemy()
        case .four:
            createEnemy()
            createEnemy()
            createEnemy()
            createEnemy()
        case .chain:
            createEnemy()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + (chainDelay / 5.0)) { [weak self] in
                self?.createEnemy()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + (chainDelay / 5.0 * 2)) { [weak self] in
                self?.createEnemy()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + (chainDelay / 5.0 * 3)) { [weak self] in
                self?.createEnemy()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + (chainDelay / 5.0 * 4)) { [weak self] in
                self?.createEnemy()
            }
        case .fastChain:
            createEnemy()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + (chainDelay / 10.0)) { [weak self] in
                self?.createEnemy()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + (chainDelay / 10.0 * 2)) { [weak self] in
                self?.createEnemy()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + (chainDelay / 10.0 * 3)) { [weak self] in
                self?.createEnemy()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + (chainDelay / 10.0 * 4)) { [weak self] in
                self?.createEnemy()
            }
        case .fastOne:
            createEnemy(forceBomb: .never, speed: .fast)
        }
        
        sequencePosition += 1
        nextSequenceQueued = false
    }
    
    func endGame(triggeredByBomb: Bool) {
        guard isGameEnded == false else { return }
        
        isGameEnded = true
        physicsWorld.speed = 0
        isUserInteractionEnabled = false
        
        bombSoundEffect?.stop()
        bombSoundEffect = nil
        
        if triggeredByBomb {
            livesImages[0].texture = SKTexture(imageNamed: "sliceLifeGone")
            livesImages[1].texture = SKTexture(imageNamed: "sliceLifeGone")
            livesImages[2].texture = SKTexture(imageNamed: "sliceLifeGone")
        }
        
        let gameOverLabel = SKLabelNode(fontNamed: "Chalkboard")
        gameOverLabel.text = "Game over"
        gameOverLabel.fontSize = 60
        gameOverLabel.position = CGPoint(x: Device.height / 2, y: Device.width / 2)
        gameOverLabel.horizontalAlignmentMode = .center
        
        addChild(gameOverLabel)
    }
    
    func subtractLife() {
        lives -= 1
        
        run(SKAction.playSoundFileNamed("wrong.caf", waitForCompletion: false))
        
        var life: SKSpriteNode
        
        if lives == 2 {
            life = livesImages[0]
        } else if lives == 1 {
            life = livesImages[1]
        } else {
            life = livesImages[2]
            endGame(triggeredByBomb: false)
        }
        
        life.texture = SKTexture(imageNamed: "sliceLifeGone")
        life.xScale = 1.3
        life.yScale = 1.3
        life.run(SKAction.scale(by: 1, duration: 0.1))
    }
    
}
