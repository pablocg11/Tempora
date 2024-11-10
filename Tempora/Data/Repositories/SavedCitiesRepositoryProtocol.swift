
import Foundation

protocol SavedCitiesRepositoryProtocol {
    func getSavedCities() async -> Result<[CityCoordenates], DomainError>
    func addSavedCity(_ city: CityCoordenates) async -> Result<Void, DomainError>
    func deleteSavedCity(_ city: CityCoordenates) async -> Result<Void, DomainError>
}

class SavedCitiesRepository: SavedCitiesRepositoryProtocol {
    
    private let cacheDataSource: PersistenceContainerProtocol
    
    init(cacheDataSource: PersistenceContainerProtocol) {
        self.cacheDataSource = cacheDataSource
    }
    
    func getSavedCities() async -> Result<[CityCoordenates], DomainError> {
        let result = cacheDataSource.fetchSavedCities()
                
        switch result {
        case .success(let cities):
            return cities.isEmpty ? .failure(.dataNotFound) : .success(cities)
        case .failure(let error):
            return .failure(.persistenceError(error))
        }
    }
    
    func addSavedCity(_ city: CityCoordenates) async -> Result<Void, DomainError> {
        let result = await cacheDataSource.saveCity(city)
        
        switch result {
        case .success:
            return .success(())
        case .failure(let error):
            return .failure(.persistenceError(error))
        }
    }
    
    func deleteSavedCity(_ city: CityCoordenates) async -> Result<Void, DomainError> {
        let result = await cacheDataSource.deleteCity(city)
        
        switch result {
        case .success:
            return .success(())
        case .failure(let error):
            return .failure(.persistenceError(error))
        }
    }
}
