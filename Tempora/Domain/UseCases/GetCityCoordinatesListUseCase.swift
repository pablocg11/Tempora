
import Foundation

protocol GetCityCoordinatesListUseCaseProtocol {
    func execute() async -> Result<[CityCoordenates], DomainError>
}

class GetCityCoordinatesListUseCase: GetCityCoordinatesListUseCaseProtocol {
    private let repository: CityCoordenatesRepositoryProtocol
    
    init(repository: CityCoordenatesRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async -> Result<[CityCoordenates], DomainError> {
        let result = await repository.getCityList()
        
        guard let cityList = try? result.get() else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }
            return .failure(error)
        }
        
        let sortedCityList = cityList.sorted { $0.name < $1.name }
        return .success(sortedCityList)
    }
}
