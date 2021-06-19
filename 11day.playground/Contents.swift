import UIKit

protocol Identifiable {
    var id: String { get set }
    var name: String { get set }
  
}

struct User: Identifiable {
    var name: String
    var id: String
}

func displayID(thing: Identifiable) {
    print("My ID is \(thing.id)")
}

protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(days: Int)
}

protocol Employee: Payable, NeedsTraining, HasVacation { }

struct theStruct: Employee {
    func calculateWages() -> Int {
        0
    }
    
    func study() {
        print(#function)
    }
    
    func takeVacation(days: Int) {
        print(#function)
    }
}

extension Int {
    func squared() -> Int {
        return self * self
    }
}

let number = 8

number.squared()

extension Double {
    var isNegative: Bool {
        return self < 0
    }
}

let double = 0.1

double.isNegative

let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = Set(["John", "Paul", "George"])

extension Collection {
    func summarize() {
        print("There are \(self.count) of us:")
        print(type(of: self))
        
        for name in self {
            print(name)
        }
    }
}

pythons.summarize()
beatles.summarize()

let user: User = User(name: "hhh", id: "222")

extension User: SuperHeroMovie {
    func writeScript() -> String {
        "aaa"
    }
    
    func userPrint() {
        print(self)
        print(type(of: self))
    }
}

user.userPrint()

protocol SuperHeroMovie {
    func writeScript() -> String
}
extension SuperHeroMovie {
    func makeScript() -> String {
        return """
        Lots of special effects,
        some half-baked jokes,
        and a hint of another
        sequel at the end.
        """
    }
    func newsefe() -> String {
        "ggg"
    }
}

user.makeScript()
user.newsefe()
