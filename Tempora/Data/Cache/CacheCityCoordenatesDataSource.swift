
import Foundation

protocol CacheCityCoordenatesDataSourceProtocol {
    func getCityCoordenates() async -> [CityCoordenates]
    func saveCityCoordenatesList(_ cityList: [CityCoordenates]) async
    func saveCityCoordenates(_ city: CityCoordenates) async
    func deleteCityCoordenates(_ city: CityCoordenates) async
}

class CacheCityCoordenatesDataSource: CacheCityCoordenatesDataSourceProtocol {
    private static let sharedInstance = CacheCityCoordenatesDataSource()
    private var cityList: [CityCoordenates] = []
    
    private init() {}
    
    static func shared() -> CacheCityCoordenatesDataSource {
        return sharedInstance
    }
    
    func getCityCoordenates() async -> [CityCoordenates] {
        return cityList
    }
    
    func saveCityCoordenatesList(_ cityList: [CityCoordenates]) async {
        self.cityList = cityList
    }
    
    func saveCityCoordenates(_ city: CityCoordenates) async {
        if !cityList.contains(where: { $0.name == city.name }) {
            cityList.append(city)
        }
    }
    
    func deleteCityCoordenates(_ city: CityCoordenates) async {
        if cityList.contains(where: { $0.name == city.name} ) {
            cityList.removeAll(where: { $0.name == city.name} )
        }
    }
}
