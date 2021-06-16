
struct Sport {
    var name: String
    var isOlympicSport: Bool
    
    var olympicStatus: String {
        if isOlympicSport {
            return "\(name) is an Olympic sport"
        } else {
            return "\(name) is not an Olympic sport"
        }
    }
}

let chessBoxing = Sport(name: "Chessboxing", isOlympicSport: false)
print(chessBoxing.olympicStatus)

struct Progress {
    var task: String
    var amount: Int = 19 {
        didSet {
            print("amount did set: \(oldValue)% -> \(amount)% ")
        }
    }
}

var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30
progress.amount = 80
progress.amount = 100


struct City {
    var population: Int = 80
    static var staticPopulation: Int = 80
    static func collectTaxes() -> Int {
        staticPopulation * 1_000
    }
}

let london = City(population: 9_000_000)
//london.collectTaxes()
City.collectTaxes()


struct Person {
    var name: String
    
    mutating func makeAnonymous() {
//        name = "Anonymous"
        print("makeAnonymous")
    }
}

var person = Person(name: "hong")

person.makeAnonymous()

let string = "Do or do not, there is no try."
print(string.count)
print(string.hasPrefix("Do"))
print(string.hasSuffix("o try."))
print(string.hasSuffix(" try."))
print(string.hasSuffix("try."))
print(string.hasSuffix("ry."))
print(string.hasSuffix("y."))
print(string.uppercased())
print(string.sorted())
print(string.sorted(by: {$0 > $1}))

let emoji = "👯‍♀️"
print(emoji.sorted())
print(emoji.count)

var toys = ["Woody"]
toys.capacity
toys.count
toys.debugDescription
toys.append("Buzz")
toys.endIndex
type(of: toys.endIndex)
toys[0]
toys[1]
toys.firstIndex(of: "Buzz")
toys.remove(at: 1)
toys.remove(at: 0)

let tens = [30, 20, 10]
tens.sorted()
