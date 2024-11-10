
import Foundation

protocol PersistenceContainerProtocol {
    func fetchSavedCities() -> Result<[CityCoordenates], DomainError>
    func saveCity(_ city: CityCoordenates) async -> Result<Void, DomainError>
    func deleteCity(_ city: CityCoordenates) async -> Result<Void, DomainError>
}
