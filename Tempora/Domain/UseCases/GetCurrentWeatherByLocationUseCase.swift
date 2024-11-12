
import Foundation

protocol GetCurrentWeatherByLocationUseCaseType {
    func execute(forLat lat: Double, forLon lon: Double) async -> Result<WeatherResponse, DomainError>
}

class GetCurrentWeatherByLocationUseCaseImpl: GetCurrentWeatherByLocationUseCaseType {
    
    private let repository: CurrentWeatherRepository
    
    init(repository: CurrentWeatherRepository) {
        self.repository = repository
    }
    
    func execute(forLat lat: Double, forLon lon: Double) async -> Result<WeatherResponse, DomainError> {
        return await repository.getCurrentWeather(forLat: lat, forLon: lon)
    }
}
