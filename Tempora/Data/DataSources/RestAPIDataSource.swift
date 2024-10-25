
import Foundation

class RestAPIDataSource: APICurrentWeatherDataSourceProtocol {
    
    private let httpClient: HTTPClientProtocol
    private let baseUrl = "https://api.openweathermap.org/data/2.5/weather"
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func getCurrentWeatherByLocation(forLat lat: Double, forLon lon: Double) async -> Result<WeatherResponse, HTTPClientError> {

        let parameters = [
            "lat": String(lat),
            "lon": String(lon),
            "appid": "5eebecb636f9b6fd795bdd2c241a34e4",
            "units": "metric"
        ]
        
        let request = HTTPRequest(baseURL: baseUrl, method: .get, queryParams: parameters)
        let result = await httpClient.makeRequest(request)
        
        switch result {
        case .success(let data):
            do {
                let forecast = try JSONDecoder().decode(WeatherResponse.self, from: data)
                return .success(forecast)
            } catch {
                return .failure(.parsingError)
            }
            
        case .failure(let error):
            return .failure(handleError(error: error))
        }
    }
    
    private func handleError(error: HTTPClientError?) -> HTTPClientError {
        guard let error = error else { return .generic }
        return error
    }
}
