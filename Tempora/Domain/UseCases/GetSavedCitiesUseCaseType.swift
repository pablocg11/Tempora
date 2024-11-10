
import Foundation

protocol GetSavedCitiesUseCaseType {
    func execute() async -> Result<[CityCoordenates],DomainError>
}
