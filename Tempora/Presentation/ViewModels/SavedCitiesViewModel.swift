
import Foundation

class SavedCitiesViewModel: ObservableObject {
    
    private let errorMapper: PresentationErrorMapper
    private let getSavedCitiesUseCase: GetSavedCitiesUseCaseImpl
    private let deleteSavedCitiesUseCase: DeleteSavedCitiesUseCaseImpl
    private let getWeatherUseCase: GetCurrentWeatherByLocationUseCaseImpl
    
    init(errorMapper: PresentationErrorMapper,
         getSavedCitiesUseCase: GetSavedCitiesUseCaseImpl,
         deleteSavedCitiesUseCase: DeleteSavedCitiesUseCaseImpl,
         getWeatherUseCase: GetCurrentWeatherByLocationUseCaseImpl) {
        self.errorMapper = errorMapper
        self.getSavedCitiesUseCase = getSavedCitiesUseCase
        self.deleteSavedCitiesUseCase = deleteSavedCitiesUseCase
        self.getWeatherUseCase = getWeatherUseCase
    }
    
    @Published var showLoading: Bool = false
    @Published var errorMessage: String?
    @Published var savedCities: [CityCoordenates] = []
    @Published var savedCitiesWeather: [CityWeather] = []
    
    func handleError(_ error: DomainError?) {
        Task { @MainActor in
            showLoading = false
            errorMessage = errorMapper.map(error: error)
        }
    }
    
    func onAppear() {
        getAllSavedCities()
    }
    
    func getAllSavedCities() {
        showLoading = true
        
        Task {
            let result  = await getSavedCitiesUseCase.execute()
            switch result {
            case .success(let cities):
                await MainActor.run {
                    self.errorMessage = nil
                    self.savedCities = cities
                    self.savedCitiesWeather.removeAll()
                }
                await getWeatherForSavedCities(cities)
                
                await MainActor.run {
                    self.showLoading = false
                }
                
            case .failure(let error):
                handleError(error)
            }
        }
    }
    
    func deleteSavedCity(_ city: CityCoordenates) {
        Task {
            let result = await deleteSavedCitiesUseCase.execute(delete: city)
            switch result {
            case .success:
                await MainActor.run {
                    self.showLoading = false
                    self.errorMessage = nil
                    self.savedCities.removeAll { $0 == city }
                }
            case .failure(let error):
                await MainActor.run {
                    handleError(error)
                }
            }
        }
    }
    
    private func getWeatherForSavedCities(_ cities: [CityCoordenates]) async {
        for city in cities {
            let result = await getWeatherUseCase.execute(forLat: city.lat, forLon: city.lon)
            switch result {
            case .success(let weather):
                await MainActor.run {
                    self.savedCitiesWeather.append(CityWeather(city: city, weather: weather))
                }
            case .failure(let error):
                handleError(error)
            }
        }
    }
}
