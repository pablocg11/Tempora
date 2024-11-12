
import Foundation

protocol RemoveCityCoordenatesUseCaseProtocol {
    func execute(city: CityCoordenates) async -> Result<Void, DomainError>
}

class RemoveCityCoordenatesUseCase: RemoveCityCoordenatesUseCaseProtocol {
    private let repository: CityCoordenatesRepositoryProtocol
    
    init(repository: CityCoordenatesRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(city: CityCoordenates) async -> Result<Void, DomainError> {
        await self.repository.deleteCity(city)
    }
}
