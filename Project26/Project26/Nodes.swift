//
//  Nodes.swift
//  Project26
//
//  Created by JEONGSEOB HONG on 2021/09/06.
//

import SpriteKit

class BlockSpriteNode: SKSpriteNode {
    init(imageName: String, position: CGPoint) {
        super.init(texture: nil, color: .black, size: .zero)
        
        texture = SKTexture(imageNamed: imageName)
        size = texture!.size()
        name = imageName
        self.position = position
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.categoryBitMask = CollisionTypes.wall.rawValue
        physicsBody?.isDynamic = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class StarSpriteNode: SKSpriteNode {
    init(imageName: String, position: CGPoint) {
        super.init(texture: nil, color: .black, size: .zero)
        
        texture = SKTexture(imageNamed: imageName)
        size = texture!.size()
        name = imageName
        self.position = position
        physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        physicsBody?.isDynamic = false
        
        physicsBody?.categoryBitMask = CollisionTypes.star.rawValue
        physicsBody?.collisionBitMask = CollisionTypes.player.rawValue
        physicsBody?.contactTestBitMask = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VortexSpriteNode: SKSpriteNode {
    init(imageName: String, position: CGPoint) {
        super.init(texture: nil, color: .black, size: .zero)
        
        texture = SKTexture(imageNamed: imageName)
        size = texture!.size()
        name = imageName
        self.position = position
        run(SKAction.repeatForever(SKAction.rotate(byAngle: .pi, duration: 1)))
        physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        physicsBody?.isDynamic = false
        
        physicsBody?.categoryBitMask = CollisionTypes.vortex.rawValue
        physicsBody?.collisionBitMask = CollisionTypes.player.rawValue
        physicsBody?.contactTestBitMask = 0
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class FinishSpriteNode: SKSpriteNode {
    init(imageName: String, position: CGPoint) {
        super.init(texture: nil, color: .black, size: .zero)
        
        texture = SKTexture(imageNamed: imageName)
        size = texture!.size()
        name = imageName
        self.position = position
        physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        physicsBody?.isDynamic = false
        
        physicsBody?.categoryBitMask = CollisionTypes.finish.rawValue
        physicsBody?.collisionBitMask = CollisionTypes.player.rawValue
        physicsBody?.contactTestBitMask = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TeleportSpriteNode: SKSpriteNode {
    init(imageName: String, position: CGPoint) {
        super.init(texture: nil, color: .black, size: .zero)
        
        texture = SKTexture(imageNamed: "vortex")
        size = texture!.size()
        name = imageName
        colorBlendFactor = 1
        color = .blue
        self.position = position
        run(SKAction.repeatForever(SKAction.rotate(byAngle: .pi, duration: 1)))
        physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        physicsBody?.isDynamic = false
        
        physicsBody?.categoryBitMask = CollisionTypes.teleport.rawValue
        physicsBody?.collisionBitMask = CollisionTypes.player.rawValue
        physicsBody?.contactTestBitMask = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

