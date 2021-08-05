//
//  AnswersLabel.swift
//  Project8
//
//  Created by JEONGSEOB HONG on 2021/08/05.
//

import UIKit

class AnswersLabel: UILabel {
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        font = .systemFont(ofSize: 24)
        text = "ANSWERS"
        textAlignment = .right
        numberOfLines = 0
        setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
