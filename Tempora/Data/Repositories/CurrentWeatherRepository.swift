
import Foundation

protocol CurrentWeatherRepositoryProtocol {
    func getCurrentWeather(forLat lat: Double, forLon lon: Double) async -> Result<WeatherResponse, DomainError>
}

class CurrentWeatherRepository: CurrentWeatherRepositoryProtocol {
    
    private let apiDataSource: APICurrentWeatherDataSourceProtocol
    
    init(apiDataSource: APICurrentWeatherDataSourceProtocol) {
        self.apiDataSource = apiDataSource
    }

    func getCurrentWeather(forLat lat: Double, forLon lon: Double) async -> Result<WeatherResponse, DomainError> {
        let result = await apiDataSource.getCurrentWeatherByLocation(forLat: lat, forLon: lon)
        
        switch result {
        case .success(let currentWeatherDTO):
            let currentWeather = WeatherResponse(dto: currentWeatherDTO)
            if currentWeather.isEmpty {
                return .failure(.emptyResponse)
            }
            return .success(currentWeather)
            
        case .failure:
            return .failure(.generic)
        }
    }
}
