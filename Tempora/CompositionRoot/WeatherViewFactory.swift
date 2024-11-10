
import Foundation
 
class WeatherViewFactory {
    
    func createView() -> WeatherView {
        return WeatherView(vm: createViewModel())
    }
    
    private func createViewModel() -> WeatherViewModel {
        return WeatherViewModel(errorMapper: createErrorMapper(),
                                getcurrentWeatherUseCase: createGetCurrentWeatherUseCase())
    }
    
    private func createErrorMapper() -> PresentationErrorMapper {
        return PresentationErrorMapper()
    }

    private func createGetCurrentWeatherUseCase() -> GetCurrentWeatherByLocationUseCaseImpl {
        return GetCurrentWeatherByLocationUseCaseImpl(repository: createGetCurrentWeatherRepository())
    }
    
    private func createSavedCityUseCaseRepository() -> SavedCitiesRepository {
        return SavedCitiesRepository(cacheDataSource: createSavedCityCacheDataSource())
    }
    
    private func createGetCurrentWeatherRepository() -> CurrentWeatherRepository {
        return CurrentWeatherRepository(apiDataSource: createGetCurrentWeatherRepositoryApiDataSource())
    }
    
    private func createSavedCityCacheDataSource() -> PersistenceContainerProtocol {
        return PersistenceContainer.shared()
    }
    
    private func createGetCurrentWeatherRepositoryApiDataSource() -> APICurrentWeatherDataSourceProtocol {
        return RestAPIDataSource(httpClient: createHTTPClient())
    }
    
    private func createHTTPClient() -> HTTPClient {
        return HTTPClient(requestBuilder: HTTPRequestBuilder(),
                          errorsResolver: HTTPErrorsResolver())
    }
}
