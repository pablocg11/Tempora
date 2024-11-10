import Foundation

class PresentationErrorMapper {
    func map(error: DomainError?) -> String {
        guard let error = error else {
            return "An unknown error occurred. Please try again later."
        }
        
        switch error {
        case .emptyResponse:
            return "No current weather available. Try again later."
        case .locationNotFound:
            return "We couldn't find your location. Try again later."
        case .dataNotFound:
            return "Data not found. Please try again later."
        case .persistenceError(let error):
            return "Failed to save data: \(error.localizedDescription). Please try again later."
        case .generic:
            return "Something went wrong. Try again later."
        }
    }
}
