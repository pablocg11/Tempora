
import Foundation

class GetSavedCitiesUseCaseImpl: GetSavedCitiesUseCaseType {
    
    private let repository: SavedCitiesRepositoryProtocol
    
    init(repository: SavedCitiesRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async -> Result<[CityCoordenates], DomainError> {
        return await repository.getSavedCities()
    }
}
