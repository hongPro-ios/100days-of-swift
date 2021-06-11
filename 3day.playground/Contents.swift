import UIKit

let aNumber = 12

let resultNumber = aNumber % 5

let value: Double = 90000000000000001

let value2: Int = 90000000000000001

var listA = [1, 2, 3]
let listB = [3, 3]

listA + listB
listA.append(contentsOf: listB)

"Taylor" <= "Swift"
"baylor" <= "awift"

enum Sizes: Comparable {
    case small
    case medium
    case large
}

let first = Sizes.small
let second = Sizes.large
// That will print “true”, because Swift small comes before large in the enum case list.
print(first < second)


let weather = "Sunny"

switch weather {
case "Sunny":
    print("S")
    fallthrough
case "Rain":
    print("R")
default:
    print("D")
}

let score = 85

switch score {
case 0..<50:
    print("greate")
case 52...100:
    print("good")
default:
    print("don't have score")
}

print(0..<50)
type(of: 0...50)
type(of: 0..<50)
type(of: [0..<50])
type(of: Array(0..<50))

let names = ["Piper", "Alex", "Suzanne", "Gloria"]
print(names[1...])

