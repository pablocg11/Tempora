
import Foundation

protocol APICurrentWeatherDataSourceProtocol {
    func getCurrentWeatherByLocation(forLat lat: Double, forLon lon: Double) async -> Result<WeatherResponseDTO, HTTPClientError>
}
