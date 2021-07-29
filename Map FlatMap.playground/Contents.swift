let number: String? = "1"

let resultOfMap = number.map { Int($0) }
type(of: resultOfMap)

let resultOfFlatMap = number.flatMap{ Int($0) }
type(of: resultOfFlatMap)

//

let input = ["1", "5", "Fish"]
let numbersOfMap = input.map{ Int($0) }
let numbersOfCompactMap = input.compactMap{ Int($0) }
let numbersOfFlatMap = input.flatMap{ Int($0) }

print(numbersOfMap)
print(numbersOfCompactMap)
print(numbersOfFlatMap)
