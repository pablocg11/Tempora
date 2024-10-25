
import Foundation

class PresentationErrorMapper {
    func map(error: DomainError?) -> String {
        guard error == .emptyResponse else {
            return "No current weather available. Try again later"
        }
        
        return "Something went wrong. Try again later"
    }
}
