
import Foundation
 
class WeatherViewFactory {
    
    func createView() -> WeatherView {
        return WeatherView(viewModel: createViewModel())
    }
    
    private func createViewModel() -> WeatherViewModel {
        return WeatherViewModel(errorMapper: createErrorMapper(),
                                getcurrentWeatherUseCase: createGetCurrentWeatherUseCase())
    }
    
    private func createErrorMapper() -> PresentationErrorMapper {
        return PresentationErrorMapper()
    }
    
    private func createGetCurrentWeatherUseCase() -> GetCurrentWeatherByLocationUseCaseImpl {
        GetCurrentWeatherByLocationUseCaseImpl(repository: getCurrentWeatherRepository())
    }
    
    private func getCurrentWeatherRepository() -> CurrentWeatherRepository {
        return CurrentWeatherRepository(apiDataSource: getCurrentWeatherRepositoryApiDataSource())
    }
    
    private func getCurrentWeatherRepositoryApiDataSource() -> APICurrentWeatherDataSourceProtocol {
        return RestAPIDataSource(httpClient: createHTTPClient())
    }
    
    private func createHTTPClient() -> HTTPClient {
        return HTTPClient(requestBuilder: HTTPRequestBuilder(),
                          errorsResolver: HTTPErrorsResolver())
    }
}
