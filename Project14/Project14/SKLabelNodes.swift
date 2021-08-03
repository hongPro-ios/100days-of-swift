//
//  SKLabelNodes.swift
//  Project14
//
//  Created by JEONGSEOB HONG on 2021/08/03.
//


import SpriteKit

class GameScoreLabel: SKLabelNode {
    init(at position: CGPoint) {
        super.init()
        fontName = "Chalkduster"
        text = "Score: 0"
        self.position = position
        horizontalAlignmentMode = .left
        fontSize = 48
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class FinalScoreLabel: SKLabelNode {
    override init() {
        super.init()
        fontName = "Chalkduster"
        position = CGPoint(x: 512, y: 384 - 100)
        zPosition = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
