import UIKit

var variableName = ""
let constantName = ""

var name = "Hong Jeongseob"

var latitude: Double
latitude = 36.166667
latitude = 360.166667
latitude = 3600.166667
latitude = 36000.166667
latitude = 36000.16666711111111111111

var longitude: Float
longitude = -1286.783333
longitude = -12860.783333
longitude = -128600.783333
longitude = -1286000.783333
longitude = -12860000.783333

let maxInt = Int.max
let minInt = Int.min
let maxUInt8 = UInt8.max
let minUInt8 = UInt8.min
let maxUInt16 = UInt16.max
let minUInt16 = UInt16.min
let maxUInt32 = UInt32.max
let minUInt32 = UInt32.min
let maxUInt64 = UInt64.max
let minUInt64 = UInt64.min


var a = 10
a = a + 1
a = a - 1
a = a * a

var b = 10
b += 10
b -= 10

var evenNumbers = [1, 2, 3]
type(of: evenNumbers)

for _ in 0..<evenNumbers.endIndex {
    print("hh")
}

var songs = ["Shake it Off", "You Belong with Me", "Love Story"]
var songs2 = ["Today was a Fairytale", "Welcome to New York", "Fifteen"]
var both = songs + songs2
both += ["hhh"]

var str = "Fakers gonna"

(1...5).reduce(str) { result, _ in
    result + " fake"
}

