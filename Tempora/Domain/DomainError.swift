
import Foundation

enum DomainError: Error {
    case generic
    case emptyResponse
    case locationNotFound
    case dataNotFound
    case tooManyRequest
    case persistenceError(Error)
}
