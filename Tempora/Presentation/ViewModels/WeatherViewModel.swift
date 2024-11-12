
import Foundation
import CoreLocation

class WeatherViewModel: ObservableObject {
    
    private let errorMapper: PresentationErrorMapper
    private let getcurrentWeatherUseCase: GetCurrentWeatherByLocationUseCaseImpl
    
    init(errorMapper: PresentationErrorMapper,
         getcurrentWeatherUseCase: GetCurrentWeatherByLocationUseCaseImpl) {
        self.errorMapper = errorMapper
        self.getcurrentWeatherUseCase = getcurrentWeatherUseCase
    }
    
    @Published var weather: WeatherResponse?
    @Published var showLoading: Bool = false
    @Published var errorMessage: String?
    @Published var selectedUnit: String = "C"
    @Published var isCityFavorite: Bool = false
    
    func onAppear() {
        getLatAndLongFromLocation(location: "Madrid") { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let (lat, lon)):
                let city = CityCoordenates(name: "Madrid", lat: lat, lon: lon)
                Task { @MainActor in
                    self.requestCurrentWeatherFromLocation(forLat: lat, forLon: lon)
                }
                
            case .failure(let error):
                self.handleError(error)
            }
        }
    }
    
    func getLatAndLongFromLocation(location: String, completion: @escaping (Result<(Double, Double), DomainError>) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { placemarks, error in
            if let error = error as? CLError, error.code == .locationUnknown {
                completion(.failure(.locationNotFound))
                return
            } else if error != nil {
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

    func requestCurrentWeatherFromLocation(forLat lat: Double, forLon lon: Double) {
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
    
    private func handleError(_ error: DomainError?) {
        Task { @MainActor in
            showLoading = false
            errorMessage = errorMapper.map(error: error)
        }
    }
}
