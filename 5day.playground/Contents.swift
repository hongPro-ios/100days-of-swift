import Foundation

func square(numbers: Int...) {
    for number in numbers {
        print(number * number)
    }
}

square(numbers: )

enum PasswordError: Error {
    case obvious
    
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }

    return true
}

do {
    try checkPassword("password")
    print("normal")
} catch {
    print("throwed")
}

func doubleInPlace(number: inout Int) {
    number *= 2
}

var myNum = 10
doubleInPlace(number: &myNum)

