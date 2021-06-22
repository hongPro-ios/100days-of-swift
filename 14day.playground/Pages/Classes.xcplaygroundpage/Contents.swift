import Foundation

class Singer {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    func sing() {
        print("lalalala")
    }
    
    @objc func singObjectiveC() {
        print("singObjectiveC")
    }
}

var singer = Singer(name: "Same", age: 12)
singer.sing()

class CountrySinger: Singer {
    override func sing() {
        print("hohohohoh  country!~~")
    }
}

var countrySinger = CountrySinger(name: "bob", age: 23)
countrySinger.sing()

class HeavyMetalSinger: Singer  {
    var noiseLevel: Int
    
    init(name: String, age: Int, noiseLevel: Int) {
        self.noiseLevel = noiseLevel
        super.init(name: name, age: age)
    }
}

let heavyMetalSinger = HeavyMetalSinger(name: "HeavyMan", age: 1000, noiseLevel: 1000)
heavyMetalSinger.noiseLevel
heavyMetalSinger.sing()
heavyMetalSinger.singObjectiveC()
