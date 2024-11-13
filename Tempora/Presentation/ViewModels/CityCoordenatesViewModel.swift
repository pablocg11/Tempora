
import Foundation

class CityCoordenatesViewModel: ObservableObject {
    private let errorMapper: PresentationErrorMapper
    private let getCityCoordenatesListUseCase: GetCityCoordinatesListUseCaseProtocol
    private let saveCityCoordenatesUseCase: SaveCityCoordenatesUseCaseProtocol
    
    init(errorMapper: PresentationErrorMapper,
         getCityCoordenatesListUseCase: GetCityCoordinatesListUseCaseProtocol,
         saveCityCoordenatesUseCase: SaveCityCoordenatesUseCaseProtocol) {
        self.errorMapper = errorMapper
        self.getCityCoordenatesListUseCase = getCityCoordenatesListUseCase
        self.saveCityCoordenatesUseCase = saveCityCoordenatesUseCase
    }
    
    @Published var cities: [CityCoordenates] = []
    @Published var errorMessage: String?
    @Published var showLoading: Bool = false
    
    func onAppear() {
        showLoading = true
        
        Task {
            let result = await self.getCityCoordenatesListUseCase.execute()
            switch result {
            case .success(let cities):
                await MainActor.run {
                    self.showLoading = false
                    self.errorMessage = nil
                    self.cities = cities
                }
            case .failure(let error):
                handleError(error)
            }
        }        
    }
    
    func saveCityCoordenates(_ cityCoordenates: CityCoordenates) async {
        Task {
            let result = await saveCityCoordenatesUseCase.execute(city: cityCoordenates)
            await MainActor.run {
                switch result {
                case .success:
                    print("Ciudad guardada con éxito")
                case .failure(let error):
                    self.errorMessage = errorMapper.map(error: error)
                    print("Error al guardar la ciudad: \(self.errorMessage ?? "Desconocido")")
                }
            }
        }
    }
    
    func isCityFavorite(_ city: CityCoordenates) -> Bool {
        return cities.contains(where: { $0.id == city.id })
    }

    private func handleError(_ error: DomainError?) {
        Task { @MainActor in
            showLoading = false
            errorMessage = errorMapper.map(error: error)
        }
    }
}

