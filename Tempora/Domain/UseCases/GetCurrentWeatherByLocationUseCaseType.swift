
import Foundation

protocol GetCurrentWeatherByLocationUseCaseType {
    func execute(forLat lat: Double, forLon lon: Double) async -> Result<WeatherResponse, DomainError>
}
