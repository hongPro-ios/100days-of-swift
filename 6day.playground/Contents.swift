import UIKit

let driving = {
    print("I'm driving")
}

driving()


var signAutograph: (String) -> Void = { (name: String) in
    print("To \(name), my #1 fan")
}
signAutograph("Lisa")


let closureWithOneParameter = { (place: String) in
    print("\(place)")
}

closureWithOneParameter("hey")

func travel(inputAction action: (String) -> Void) {
    print("I'm getting ready to go.")
    action("The place")
}

travel(inputAction: { name in print(name)})

travel() { name in print(name) }

travel { name in print(name) }

travel { print($0) }

