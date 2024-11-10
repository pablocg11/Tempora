
import Foundation

class CustomHourFormatter {
    
    static let shared = CustomHourFormatter()
    
    private let dateFormatter: DateFormatter
    
    private init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a" 
    }
    
    func string(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
