import Foundation


var age: Int? = nil

age = 38

var name: String? = nil
name?.count
name = "hong"

guard let name = name else { fatalError() }

let menuItems: [String]? = ["Pizza", "Pasta"]
if let items = menuItems {
    print("There are \(menuItems?.count) items to choose from.")
}

let str = "5"
let num = Int(str)

let url = URL(string: "https://www.apple.com")

let tupleNumber = (1...10).randomElement()
tupleNumber

var implicitlyAge: Int! = nil
implicitlyAge

func optionalValue() -> String? {
    "hey"
}

let value = optionalValue() ?? "h"
type(of: value)

let names = ["Vincent": "van Gogh", "Pablo": "Picasso", "Claude": "Monet"]
let surnameLetter = names["Vincent"]?.first?.uppercased()

let dic: [String: String] = [:]
let dic2 = [String: String]()

enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }

    return true
}


if let result = try? checkPassword("1password") {
    print("Result was \(result)")
} else {
    print("D'oh.")
}

struct Person {
    var id: String
    
    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}

class Animal { }
class Fish: Animal {}
class Dog: Animal {
    func makeNoise() {
        print("woof!")
    }
}

let pets = [Fish(), Dog(), Fish(), Animal(), Dog()]
print("-------")
pets.forEach { element in
    print("start: \(type(of: element))")

    if let dog = element as? Dog {
        print("end1: \(type(of: element))")
        dog.makeNoise()
    } else {
        print("end2: \(type(of: element))")
    }
    
}
