import UIKit

func favoriteAlbum(name: String) {
    print("My favorite is \(name)")
}

favoriteAlbum(name: "Fearless")

func printAlbumRelease(name: String, year: Int) {
    
}

func countLetters(in string: String) {
    print("The string \(string) has \(string.count) letters")
}

countLetters(in: "Hello")

func albumIsTaylors(name: String) -> Bool {
    if name == "Taylor Swift" { return true }
    return false
}


if albumIsTaylors(name: "Taylor Swift") {
    print("That's one of hers")
} else {
    print("Who made that?")
}

