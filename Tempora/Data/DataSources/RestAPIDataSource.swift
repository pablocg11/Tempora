
import Foundation

class RestAPIDataSource: APICurrentWeatherDataSourceProtocol {
    
    private let httpClient: HTTPClientProtocol
    private let baseUrl = "https://api.openweathermap.org/data/2.5/weather"
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func getCurrentWeatherByLocation(forLat lat: Double, forLon lon: Double) async -> Result<WeatherResponseDTO, HTTPClientError> {

        let parameters = [
            "lat": String(lat),
            "lon": String(lon),
            "appid": "5eebecb636f9b6fd795bdd2c241a34e4"
        ]
        
        let request = HTTPRequest(baseURL: baseUrl, method: .get, queryParams: parameters)
        let result = await httpClient.makeRequest(request)
        
        switch result {
        case .success(let data):
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponseDTO.self, from: data)
                return .success(weatherResponse)
            } catch {
                print("Error al decodificar JSON:", error)
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("JSON recibido: \(jsonString)")
                }
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
