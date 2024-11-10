
import Foundation

protocol AddSavedCityUseCaseType {
    func execute(add city: CityCoordenates) async -> Result<Void, DomainError> 
}
