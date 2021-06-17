import UIKit

struct User {
    var username: String
}

extension User {
    init() {
        self.username = "hey"
    }

}

var user = User(username: "hey")

struct Person {
    static let num = 1
    var name: String
    lazy var age: Int = 8
    init(name: String) {
        self.name = name
    }
}

var ed = Person(name: "hong")
ed.age

struct Pokemon {
    static var numberCaught = 0
    var name: String
    static func catchPokemon() {
        print("Caught!")
        numberCaught += 1
    }
    
    mutating func changeNameProperty() {
        name = "hhhh"
    }
}


