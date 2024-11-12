
import Foundation

class SwiftDataCacheDataSource: CacheCityCoordenatesDataSourceProtocol {
    private let container: SwiftDataContainerProtocol
    
    init(container: SwiftDataContainerProtocol) {
        self.container = container
    }
    
    func getCityCoordenates() async -> [CityCoordenates] {
        let result = container.fetchCities()
        let cities = result.map { CityCoordenates(id: $0.id, name: $0.name, lat: $0.lat, lon: $0.lon) }
        
        return cities
    }
    
    func saveCityCoordenatesList(_ cityList: [CityCoordenates]) async {
        let cities = cityList.map { CityCoordenates(id: $0.id, name: $0.name, lat: $0.lat, lon: $0.lon) }
        await container.insertCities(cities)
    }
    
    func saveCityCoordenates(_ city: CityCoordenates) async {
        await container.insertCity(city)
    }
    
    func deleteCityCoordenates(_ city: CityCoordenates) async {
        await container.deleteCity(city)
    }
}
