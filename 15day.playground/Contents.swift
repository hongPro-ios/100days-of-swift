
class Hong {
    private var name1: String?
    fileprivate var name2: String?
    internal var name3: String?
    public var name4: String?
    open var name5: String?
}

private class Hong1 {
    public var name1: String = ""
}
fileprivate class Hong2 {}
internal class Hong3 {}
public class Hong4 {}
open  class Hong5 {}

//var hong1 = Hong1()
//var hong2 = Hong2()
var hong3 = Hong3()
var hong4 = Hong4()
var hong5 = Hong5()



class Album {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func getPerformance() -> String {
        return "The album \(name) sold lots"
    }
}

class StudioAlbum: Album {
    var studio: String
    
    init(name: String, studio: String) {
        self.studio = studio
        super.init(name: name)
    }
    
    override func getPerformance() -> String {
        return "The studio album \(name) sold lots"
    }
}

class LiveAlbum: Album {
    var location: String
    
    init(name: String, location: String) {
        self.location = location
        super.init(name: name)
    }
    
    override func getPerformance() -> String {
        return "The live album \(name) sold lots"
    }
}

var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studios")
var fearless = StudioAlbum(name: "Speak Now", studio: "Aimeeland Studio")
var iTunesLive = LiveAlbum(name: "iTunes Live from SoHo", location: "New York")

var allAlbums: [Album] = [taylorSwift, fearless, iTunesLive]

for album in allAlbums {
    print(album.getPerformance())
    if let studioAlbum = album as? StudioAlbum {
        print(studioAlbum.studio)
    } else if let liveAlbum = album as? LiveAlbum {
        print(liveAlbum.location)
    }
}


for album in allAlbums as? [StudioAlbum] ?? [StudioAlbum]() {
    print("hoho")
    print(album.studio)
}
