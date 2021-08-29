//: [Previous](@previous)

// Challenge2
// Extend Int with a times() method that runs a closure as many times as the number is high. For example, 5.times { print("Hello!") } will print “Hello” five times.

extension Int {
    func times(closure: () -> Void) {
        guard self > 0 else { return }

        for _ in 0..<self {
            closure()
        }
    }
}

5.times {
    print("hey")
}

0.times {
    print("buddy")
}

//: [Next](@next)
