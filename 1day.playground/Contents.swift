import Foundation

var greeting = "Hello, playground"

var age = 31
var multipleLine = """
    hey
    hey
    """

var multipleLineWithoutBackSlash = """
    let \
    do \
    hey\
    man
    """


class Animal {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

let dog = Animal(name: "happy")

"hi \(dog.name)"
