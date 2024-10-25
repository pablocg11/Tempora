
import Foundation

protocol APICurrentWeatherDataSourceProtocol {
    func getCurrentWeatherByLocation(forLat lat: Double, forLon lon: Double) async -> Result<WeatherResponse, HTTPClientError>
}
