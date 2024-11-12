
import Foundation

protocol CityCoordenatesRepositoryProtocol {
    func getCityList() async -> Result<[CityCoordenates], DomainError>
    func saveCity(_ city: CityCoordenates) async -> Result<Void, DomainError>
    func deleteCity(_ city: CityCoordenates) async -> Result<Void, DomainError>
}

class CityCoordenatesRepository: CityCoordenatesRepositoryProtocol {
    private let cacheDataSource: CacheCityCoordenatesDataSourceProtocol
    private let errorMapper: DomainErrorMapper
    
    init(cacheDataSource: CacheCityCoordenatesDataSourceProtocol, errorMapper: DomainErrorMapper) {
        self.cacheDataSource = cacheDataSource
        self.errorMapper = errorMapper
    }
    
    func getCityList() async -> Result<[CityCoordenates], DomainError> {
        let cityCoordenatesCache = await cacheDataSource.getCityCoordenates()
        if !cityCoordenatesCache.isEmpty {
            return(.success(cityCoordenatesCache))
        }
        else {
            return .success([])
        }
    }
    
    func saveCity(_ city: CityCoordenates) async -> Result<Void, DomainError> {
        do {
            try await cacheDataSource.saveCityCoordenates(city) 
            return .success(())
        } catch let error as DomainError {
            return .failure(error)
        } catch {
            return .failure(.generic)
        }
    }
    
    func deleteCity(_ city: CityCoordenates) async -> Result<Void, DomainError> {
        do {
            try await cacheDataSource.deleteCityCoordenates(city)
            return .success(())
        } catch let error as DomainError {
            return .failure(error)
        } catch {
            return .failure(.generic)
        }
    }
}
