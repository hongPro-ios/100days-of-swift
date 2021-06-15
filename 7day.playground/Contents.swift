import Foundation


func sayTravelPlan(action: (String) -> Void) {
    print("Planning Travel")
    action("Rent car")
    action("Reservate hotel")
    print("Check all of plan")
}

//sayTravelPlan(action: { theDo in print("Ready \(theDo)")})

//sayTravelPlan { theDo in
//    print("Ready \(theDo)")
//}

sayTravelPlan { print("Ready \($0)") }

let changeSpeed = { (speed: Int) in
    print("Changing speed to \(speed)kph")
}

func changeSpeedFunc(speed: Int) {
    print("Changing speed to \(speed)kph")
}

func buildCar(name: String, engine: (Int) -> Void) {
    // build the car
    engine(2)
}

buildCar(name: "carName", engine: changeSpeedFunc)

func playSong(_ name: String, notes: () -> String) {
    print("I'm going to play \(name).")
    let playedNotes = notes()
    print(playedNotes)
}
playSong("Mary Had a Little Lamb") { "EDCDEEEDDDEGG" }


func returningClosures() -> (String) -> Void {
    return { print("print out this: \($0)") }
}

var someClosure1 = returningClosures
var someClosure2 = returningClosures()

someClosure1()("ee")


func travel() -> (String) -> Void {
    var counter = 1
    return {
        print("\(counter)I'm going to \($0)")
        counter += 1
    }
}

let result = travel()
result("London")
result("London")
result("London")
result("London")


func makeRandomNumberGenerator() -> () -> Int {
    var previousNumber = 0
    
    return {
        
        var newNumber: Int

        repeat {
            newNumber = Int.random(in: 1...3)
        } while newNumber == previousNumber

        previousNumber = newNumber
        return newNumber
    }
}

let generator = makeRandomNumberGenerator()

for _ in 1...10 {
    print(generator())
}
