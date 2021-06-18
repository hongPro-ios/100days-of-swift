
class Dog {
    var name: String
    var bread: String
    
    init(name: String, bread: String) {
        self.name = name
        self.bread = name
    }
    
    func changeName() {
        name = "changed name"
    }
}


let dog = Dog(name: "doggg", bread: "bbbee")

dog.bread = "gggg"
dog.changeName()

class Poodle: Dog {
    init(name: String) {
        super.init(name: name, bread: "poodle")
    }
    override func changeName() {
        print("override")
    }
    
}

var poodle = Poodle(name: "happy")
poodle.changeName()

class Vehicle {
    var wheels: Int
    init(wheels: Int) {
        self.wheels = wheels
    }
}
class Truck: Vehicle {
    var goodsCapacity: Int
    init(wheels: Int, goodsCapacity: Int) {
        self.goodsCapacity = goodsCapacity
        super.init(wheels: wheels)
    }
}

var truck = Truck(wheels: 4, goodsCapacity: 19)

class Singer {
    var name = "Hong"
}

let singer = Singer()
print(singer.name)

let singerCopy = singer
singerCopy.name = "jeong"
print(singer.name)
print(singerCopy.name)

struct Code {
    var numberOfBugs = 100
    mutating func fixBug() {
        numberOfBugs += 3
    }
}
var code = Code()
code.fixBug()

