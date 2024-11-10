import Foundation

extension String {
    
    var unicodeFlag: String {
        let base: UInt32 = 0x1F1E6
        var flag = ""
        for character in self.uppercased() {
            if let asciiValue = character.asciiValue, asciiValue >= 65 && asciiValue <= 90 {
                let scalarValue = base + UInt32(asciiValue - 65)
                if let scalar = UnicodeScalar(scalarValue) {
                    flag.append(String(scalar))
                }
            }
        }
        return flag
    }
}
