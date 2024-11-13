
import Foundation
import CoreLocation
import Combine

class WeatherViewModel: ObservableObject {
    
    private let errorMapper: PresentationErrorMapper
    private let getcurrentWeatherUseCase: GetCurrentWeatherByLocationUseCaseImpl
    private let locationManager: LocationManager
    
    init(errorMapper: PresentationErrorMapper,
         getcurrentWeatherUseCase: GetCurrentWeatherByLocationUseCaseImpl,
         locationManager: LocationManager) {
        self.errorMapper = errorMapper
        self.getcurrentWeatherUseCase = getcurrentWeatherUseCase
        self.locationManager = locationManager
    }
    
    @Published var weather: WeatherResponse?
    @Published var showLoading: Bool = false
    @Published var errorMessage: String?
    @Published var selectedUnit: String = "C"
    @Published var isCityFavorite: Bool = false
    @Published var isLocationReady: Bool = false
    private var cancellables: Set<AnyCancellable> = []
    
    func onAppear() {
        showLoading = true
        locationManager.$authorizationStatus.sink { [weak self] status in
            guard let self = self else { return }
            
            if status == .authorizedWhenInUse || status == .authorizedAlways {
                if let location = self.locationManager.locationManager.location {
                    let lat = location.coordinate.latitude
                    let lon = location.coordinate.longitude
                    self.requestCurrentWeatherFromLocation(forLat: lat, forLon: lon)
                }
            } else {
                self.handleError(DomainError.locationNotFound)
            }
            showLoading = false
        }
        .store(in: &cancellables)
        
        locationManager.locationManager.requestLocation()
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
            
            guard let placemark = placemarks?.first, let location = placemark.location else {
                completion(.failure(.emptyResponse))
                return
            }
            
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            completion(.success((lat, lon)))
        }
    }
    
    private func handleError(_ error: DomainError?) {
        Task { @MainActor in
            showLoading = false
            errorMessage = errorMapper.map(error: error)
        }
    }
}
