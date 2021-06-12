import UIKit

let numbers = 1...10

for number in numbers {
    print(number)
}

let listName = ["hong", "jeong", "seob"]

for name in listName {
    print(name)
}

// tuple can not avaliable for loop
//let tupleName = ("hong", "jeong", "seob")
//for name in tupleName {
//    print(name)
//}

var number = 1

repeat {
    print("hey repeat 1")
} while false


outerLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print("\(i) * \(j) is \(product)")
        break outerLoop
    }
}

outerLoop: while true {
    for j in 1...10 {
        let product = j * j
        print("\(j) * \(j) is \(product)")
        break outerLoop
    }
}

