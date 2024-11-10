
import Foundation

class SavedCitiesViewFactory {
    
    func createView() -> SavedCityWeatherView {
        return SavedCityWeatherView(viewModel: createViewModel())
    }
    
    private func createViewModel() -> SavedCitiesViewModel {
        return SavedCitiesViewModel(errorMapper: createErrorMapper(),
                                    getSavedCitiesUseCase: createGetSavedCitiesUseCase(),
                                    deleteSavedCitiesUseCase: createDeleteSavedCitiesUseCase(),
                                    getWeatherUseCase: createGetCurrentWeatherUseCase())
    }
    
    private func createErrorMapper() -> PresentationErrorMapper {
        return PresentationErrorMapper()
    }
    
    private func createGetSavedCitiesUseCase() -> GetSavedCitiesUseCaseImpl {
        GetSavedCitiesUseCaseImpl(repository: createSavedCitiesRepository())
    }
    
    private func createDeleteSavedCitiesUseCase() -> DeleteSavedCitiesUseCaseImpl {
        DeleteSavedCitiesUseCaseImpl(repository: createSavedCitiesRepository())
    }
    
    private func createGetCurrentWeatherUseCase() -> GetCurrentWeatherByLocationUseCaseImpl {
        return GetCurrentWeatherByLocationUseCaseImpl(repository: createGetCurrentWeatherRepository())
    }
    
    private func createSavedCitiesRepository() -> SavedCitiesRepository {
        return SavedCitiesRepository(cacheDataSource: createSavedCityCacheDataSource())
    }
    
    private func createGetCurrentWeatherRepository() -> CurrentWeatherRepository {
        return CurrentWeatherRepository(apiDataSource: createGetCurrentWeatherRepositoryApiDataSource())
    }
    
    private func createGetCurrentWeatherRepositoryApiDataSource() -> APICurrentWeatherDataSourceProtocol {
        return RestAPIDataSource(httpClient: createHTTPClient())
    }
    
    private func createHTTPClient() -> HTTPClient {
        return HTTPClient(requestBuilder: HTTPRequestBuilder(),
                          errorsResolver: HTTPErrorsResolver())
    }
    
    private func createSavedCityCacheDataSource() -> PersistenceContainerProtocol {
        return PersistenceContainer.shared()
    }
    
}
