//
//  ScoreLabel.swift
//  Project8
//
//  Created by JEONGSEOB HONG on 2021/07/16.
//

import UIKit

class ScoreLabel: UILabel {
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .right
        text = "Score : 0"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
