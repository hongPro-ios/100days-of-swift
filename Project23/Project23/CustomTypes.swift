//
//  Constants.swift
//  Project23
//
//  Created by JEONGSEOB HONG on 2021/08/26.
//

import Foundation

enum Speed {
    case normal
    case fast
}

enum Device {
    static let height = 1024
    static let width = 768
}

enum ForceBomb {
    case never, always, random
}

enum SequenceType: CaseIterable {
    case oneNoBomb, one, twoWithOneBomb, two, three, four, chain, fastChain, fastOne
}

enum EnemyType {
    case bomb
    case penguin
}
