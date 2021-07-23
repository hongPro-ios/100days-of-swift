//
//  GameScene.swift
//  Project11
//
//  Created by JEONGSEOB HONG on 2021/07/23.
//

import SpriteKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
       let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 1024 / 2, y: 768 / 2)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        let positionsBouncer: [CGPoint] = [.init(x: 0, y: 0),
                                           .init(x: 256, y: 0),
                                           .init(x: 512, y: 0),
                                           .init(x: 768, y: 0),
                                           .init(x: 1024, y: 0),
        ]
        positionsBouncer.forEach { position in
            makeBouncer(at: position)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        let ball = SKSpriteNode(imageNamed: "ballRed")
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
        ball.physicsBody?.restitution = 0.4
        ball.position = location
        addChild(ball)
    }
    
    func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2)
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
    }

}
