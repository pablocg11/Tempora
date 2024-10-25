import Foundation

class CustomDateFormatter {
    
    static let shared = CustomDateFormatter()
    
    private let dateFormatter: DateFormatter
    
    private init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, h:mm a"
    }
    
    func string(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
