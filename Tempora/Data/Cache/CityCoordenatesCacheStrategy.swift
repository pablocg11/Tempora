
import Foundation

class CityCoordenatesCacheStrategy: CacheCityCoordenatesDataSourceProtocol {
    private let temporalCache: CacheCityCoordenatesDataSourceProtocol
    private let persistanceCache: CacheCityCoordenatesDataSourceProtocol
    
    init(temporalCache: CacheCityCoordenatesDataSourceProtocol, persistanceCache: CacheCityCoordenatesDataSourceProtocol) {
        self.temporalCache = temporalCache
        self.persistanceCache = persistanceCache
    }
    
    func getCityCoordenates() async -> [CityCoordenates] {
        let temporalCityList = await temporalCache.getCityCoordenates()
        if !temporalCityList.isEmpty {
            return temporalCityList
        }
        
        let persistanceCityList = await persistanceCache.getCityCoordenates()
        await temporalCache.saveCityCoordenatesList(persistanceCityList)
                
        return persistanceCityList
    }
    
    func saveCityCoordenatesList(_ cityList: [CityCoordenates]) async {
        await temporalCache.saveCityCoordenatesList(cityList)
        await persistanceCache.saveCityCoordenatesList(cityList)
    }
    
    func saveCityCoordenates(_ city: CityCoordenates) async {
        await temporalCache.saveCityCoordenates(city)
        await persistanceCache.saveCityCoordenates(city)
    }
    
    func deleteCityCoordenates(_ city: CityCoordenates) async {
        await temporalCache.deleteCityCoordenates(city)
        await persistanceCache.deleteCityCoordenates(city)
    }
}
