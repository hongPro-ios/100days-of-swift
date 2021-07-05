//class Singer {
//    func playSong() {
//        print("Shake it off!!")
//    }
//
//    deinit {
//        print("Singer class deinit")
//    }
//
//}
//
//
//func sing() -> () -> Void {
//    let hong = Singer()
//    let kim = Singer()
//
//    let singing = { [weak hong, weak kim] in
//        hong?.playSong()
//        return
//    }
//
//    return singing
//}
//
//let singFunction = sing()
//singFunction()


var numberOfLinesLogged = 0

let logger1 = {
    numberOfLinesLogged += 1
    print("Lines logged: \(numberOfLinesLogged)")
}

logger1()

let logger2 = logger1
logger2()
print(numberOfLinesLogged)
