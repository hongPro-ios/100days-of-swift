//: [Previous](@previous)

// Challenge3
// Extend Array so that it has a mutating remove(item:) method. If the item exists more than once, it should remove only the first instance it finds. Tip: you will need to add the Comparable constraint to make this work!

extension Array where Element: Comparable  {
    mutating func remove(item: Element) {
        guard !self.isEmpty else { return }
        guard let index = self.firstIndex(of: item) else { return }
        self.remove(at: index)
    }
}
//: [Next](@next)
