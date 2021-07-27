//
//  Person.swift
//  Project10
//
//  Created by JEONGSEOB HONG on 2021/07/21.
//

import UIKit

class Person: Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
