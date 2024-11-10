
import Foundation

class DeleteSavedCitiesUseCaseImpl: DeleteSavedCityUseCaseType {
    
    let repository: SavedCitiesRepositoryProtocol
    
    init(repository: SavedCitiesRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(delete city: CityCoordenates) async -> Result<Void, DomainError> {
        await repository.deleteSavedCity(city)
    }
}
