
import Foundation
import CoreLocation

class WeatherViewModel: ObservableObject {
    
    private let errorMapper: PresentationErrorMapper
    private let getcurrentWeatherUseCase: GetCurrentWeatherByLocationUseCaseImpl
    
    @Published var weather: WeatherResponse?
    @Published var showLoading: Bool = false
    @Published var errorMessage: String?
    
    init(errorMapper: PresentationErrorMapper, getcurrentWeatherUseCase: GetCurrentWeatherByLocationUseCaseImpl) {
        self.errorMapper = errorMapper
        self.getcurrentWeatherUseCase = getcurrentWeatherUseCase
    }
    
    func handleError(_ error: DomainError?) {
        Task { @MainActor in
            showLoading = false
            errorMessage = errorMapper.map(error: error)
        }
    }
    
    func getLatAndLongFromLocation(location: String, completion: @escaping (Result<(Double, Double), DomainError>) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { placemarks, error in
            if let error = error {
                completion(.failure(.generic))
                return
            }
            
            guard let location = placemarks?.first?.location else {
                completion(.failure(.emptyResponse))  
                return
            }
            
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            completion(.success((lat, lon)))
        }
    }

    func requestCurrentWeather(forLat lat: Double, forLon lon: Double) {
        showLoading = true
        
        Task {
            let result = await self.getcurrentWeatherUseCase.execute(forLat: lat, forLon: lon)
            switch result {
            case .success(let weather):
                await MainActor.run {
                    self.showLoading = false
                    self.errorMessage = nil
                    self.weather = weather
                }
                
            case .failure(let error):
                handleError(error)
            }
        }
    }
}
