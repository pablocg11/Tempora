
import Foundation

class AddSavedCityUseCaseImpl: AddSavedCityUseCaseType {
    
    let repository: SavedCitiesRepositoryProtocol
    
    init(repository: SavedCitiesRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(add city: CityCoordenates) async -> Result<Void, DomainError> {
        await repository.addSavedCity(city)
    }
}
