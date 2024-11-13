
import Foundation
 
class WeatherViewFactory {
    
    func createView() -> WeatherView {
        return WeatherView(weatherViewModel: createWeatherViewModel(),
                           cityCoordenatesViewModel: createCityCoordenatesViewModel())
    }
    
    private func createCityCoordenatesViewModel() -> CityCoordenatesViewModel {
        return CityCoordenatesViewModel(errorMapper: PresentationErrorMapper(),
                                        getCityCoordenatesListUseCase: createGetCityCoordinatesListUseCase(),
                                        saveCityCoordenatesUseCase: createSaveCityCoordenatesUseCase())
    }
    
    private func createWeatherViewModel() -> WeatherViewModel {
        return WeatherViewModel(errorMapper: PresentationErrorMapper(),
                                getcurrentWeatherUseCase: createGetCurrentWeatherUseCase(),
                                locationManager: LocationManager())
    }
    
    private func createGetCityCoordinatesListUseCase() -> GetCityCoordinatesListUseCase {
        return GetCityCoordinatesListUseCase(repository: createCityCoordinatesRepository())
    }
    
    private func createSaveCityCoordenatesUseCase() -> SaveCityCoordenatesUseCase {
        return SaveCityCoordenatesUseCase(repository: createCityCoordinatesRepository())
    }

    private func createGetCurrentWeatherUseCase() -> GetCurrentWeatherByLocationUseCaseImpl {
        return GetCurrentWeatherByLocationUseCaseImpl(repository: createGetCurrentWeatherRepository())
    }
    
    private func createGetCurrentWeatherRepository() -> CurrentWeatherRepository {
        return CurrentWeatherRepository(apiDataSource: createGetCurrentWeatherRepositoryApiDataSource())
    }
    
    private func createCityCoordinatesRepository() -> CityCoordenatesRepository {
        return CityCoordenatesRepository(cacheDataSource: createCacheDataSource(),
                                         errorMapper: DomainErrorMapper())
    }
    
    private func createCacheDataSource() -> CacheCityCoordenatesDataSourceProtocol {
        return CityCoordenatesCacheStrategy(temporalCache: CacheCityCoordenatesDataSource.shared(),
                                            persistanceCache: SwiftDataCacheDataSource(container: SwiftDataContainer.shared()))
    }
    
    
    private func createGetCurrentWeatherRepositoryApiDataSource() -> APICurrentWeatherDataSourceProtocol {
        return RestAPIDataSource(httpClient: createHTTPClient())
    }
    
    private func createHTTPClient() -> HTTPClient {
        return HTTPClient(requestBuilder: HTTPRequestBuilder(),
                          errorsResolver: HTTPErrorsResolver())
    }
}
