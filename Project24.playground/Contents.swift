import UIKit

//let string = "This is a test string"
//
//let attributes: [NSAttributedString.Key: Any] = [
//    .foregroundColor: UIColor.white,
//    .backgroundColor: UIColor.red,
//    .font: UIFont.boldSystemFont(ofSize: 36)
//]
//
//let attributedString = NSAttributedString(string: string, attributes: attributes)

//
//let string = "This is a test string"
//let attributedString = NSMutableAttributedString(string: string)
//
//attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 8), range: NSRange(location: 0, length: 4))
//attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 5, length: 2))
//attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: NSRange(location: 8, length: 1))
//attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 32), range: NSRange(location: 10, length: 4))
//attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: NSRange(location: 15, length: 6))

//Create a String extension that adds a withPrefix() method. If the string already contains the prefix it should return itself; if it doesn’t contain the prefix, it should return itself with the prefix added. For example: "pet".withPrefix("car") should return “carpet”.
extension String {
    func withPrefix(_ addingWord: String) -> String {
        guard !self.hasPrefix(addingWord) else { return self }
        return addingWord + self
    }
}

"pet".withPrefix("car")
"carpet".withPrefix("car")
"c2arpet".withPrefix("car")

//Create a String extension that adds an isNumeric property that returns true if the string holds any sort of number. Tip: creating a Double from a String is a failable initializer.
extension String {
    var isNumeric: Bool {
        guard Double(self) != nil else { return false }
        return true
    }
}

"1".isNumeric
"23".isNumeric
"23a".isNumeric

//Create a String extension that adds a lines property that returns an array of all the lines in a string. So, “this\nis\na\ntest” should return an array with four elements.
extension String {
    var lines: [String] {
        self.components(separatedBy: "\n")
    }
}

"""
hi
my name
is
hong
""".lines

"this\nis\na\ntest".lines

