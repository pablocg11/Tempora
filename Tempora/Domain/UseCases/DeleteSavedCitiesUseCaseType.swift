
import Foundation

protocol DeleteSavedCityUseCaseType {
    func execute(delete city: CityCoordenates) async -> Result<Void, DomainError>
}
