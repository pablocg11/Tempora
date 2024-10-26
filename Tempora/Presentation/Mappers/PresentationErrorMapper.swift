
import Foundation

class PresentationErrorMapper {
    func map(error: DomainError?) -> String {
        guard error == .emptyResponse else {
            return "No current weather available. Try again later"
        }
        guard error == .locationNotFound else {
            return "We couldn't find your location. Try again later"
        }
        return "Something went wrong. Try again later"
    }
}
