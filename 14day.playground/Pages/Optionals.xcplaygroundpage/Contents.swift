

var items = [String]()
items.count
items.endIndex

var nameOptional: String?
nameOptional = "nameOptional"
type(of: nameOptional)
var name: String!
//name = "hong"
type(of: name)

print(name)
print(nameOptional)
if let name = name {
    print(name)
    
} else {
    print("a")
}
//
//func justFunc(name: String) {
//    print("working")
//}
//
//justFunc(name: name)
//justFunc(name: nameOptional
