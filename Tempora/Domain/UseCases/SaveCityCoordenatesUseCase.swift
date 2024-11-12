
import Foundation

protocol SaveCityCoordenatesUseCaseProtocol {
    func execute(city: CityCoordenates) async -> Result<Void, DomainError>
}

class SaveCityCoordenatesUseCase: SaveCityCoordenatesUseCaseProtocol {
    private let repository: CityCoordenatesRepositoryProtocol
    
    init(repository: CityCoordenatesRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(city: CityCoordenates) async -> Result<Void, DomainError> {
        await repository.saveCity(city)
    }
}
