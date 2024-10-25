
import Foundation

class CustomDateFormatter {
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM, d" 
        return formatter
    }
}
