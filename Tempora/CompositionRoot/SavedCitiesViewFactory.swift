
import Foundation

class SavedCitiesViewFactory {
    
    func createView() -> SavedCitiesView {
        return SavedCitiesView(viewModel: createViewModel())
    }
    
    private func createViewModel() -> CityCoordenatesViewModel {
        return CityCoordenatesViewModel(errorMapper: PresentationErrorMapper(),
                                        getCityCoordenatesListUseCase: createGetCityCoordinatesListUseCase(),
                                        saveCityCoordenatesUseCase: createSaveCityCoordenatesUseCase())
    }
    
    private func createGetCityCoordinatesListUseCase() -> GetCityCoordinatesListUseCase {
        return GetCityCoordinatesListUseCase(repository: createCityCoordinatesRepository())
    }
    
    private func createSaveCityCoordenatesUseCase() -> SaveCityCoordenatesUseCase {
        return SaveCityCoordenatesUseCase(repository: createCityCoordinatesRepository())
    }
    
    private func createCityCoordinatesRepository() -> CityCoordenatesRepository {
        return CityCoordenatesRepository(cacheDataSource: createCacheDataSource(),
                                         errorMapper: DomainErrorMapper())
    }
    
    private func createCacheDataSource() -> CacheCityCoordenatesDataSourceProtocol {
        return CityCoordenatesCacheStrategy(temporalCache: CacheCityCoordenatesDataSource.shared(),
                                            persistanceCache: SwiftDataCacheDataSource(container: SwiftDataContainer.shared()))
    }
}
