import UIKit

let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"

let beatles = [john, paul, george, ringo]
beatles[3]

// Set

let colors = Set(["red", "green", "blue"])

// Tuples
// 특징
// 1. You can't add or remove items from tuple; they are fixed in size
// 2. You can't change the type of items in a tuple; they always have the same types they were created
// 3.

let name = (first: "hong", last: "jeongseob")
name.0
name.first
name.1
name.last

var testTuple = ("hey", "man", 3, [1, 2, 4])
testTuple.0
testTuple.1
testTuple.3
type(of:testTuple.2)


var testArray = ["aa", "bb"]
testArray[1] = "dd"

// Dictionaries
let heights = [
    "Taylor Swift": 1.78,
    "Ed Sheeran": 2
]

//class TestObject {
//
//}
//
//let ob1 = TestObject()
//let ob2 = TestObject()
//
//let testDictionaries = [
//    ob1: 1.78,
//    ob2: 2
//]

let favoriteIceCream = [
    "Paul": "Chocolate",
    "Sophie": "Vanilla"
]

// 키에 관한 값이 없을 때 반환 값을 nil이아닌 원하는 값으로도 낼수 있다.
favoriteIceCream["Charlotte", default: "Unknown"]

enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}

let talking = Activity.talking(topic: "honghongkim")
type(of: talking)

if case let talkingInsideValue = talking {
    print(talkingInsideValue)
}
//
//print(talking)
//switch talking {
//case .talking(let hoho):
//    print(hoho)
//case .bored:
//    break
//case .running(destination: let destination):
//    break
//case .singing(volume: let volume):
//    break
//}
//
//

enum Planet: String {
    case mercury
    case venus
    case earth
    case mars
}

//let earth = Planet(rawValue: 2)
let ve = Planet.venus.rawValue
type(of: ve)
print(ve)
