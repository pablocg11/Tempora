
import Foundation
import SwiftData

protocol SwiftDataContainerProtocol {
    func fetchCities() -> [CityCoordenates]
    func insertCities(_ cities: [CityCoordenates]) async
    func insertCity(_ cities: CityCoordenates) async
    func deleteCity(_ city: CityCoordenates) async
}

class SwiftDataContainer: SwiftDataContainerProtocol {
    private static let sharedInstance = SwiftDataContainer()
    
    private let container: ModelContainer
    private let context: ModelContext
    
    private init() {
        let schema = Schema([CityCoordenates.self])
        container = try! ModelContainer(for: schema, configurations: [])
        context = ModelContext(container)
    }
    
    static func shared() -> SwiftDataContainer {
        return sharedInstance
    }
    
    func fetchCities() -> [CityCoordenates] {
        let descriptor = FetchDescriptor<CityCoordenates>()
        guard let cities = try? context.fetch(descriptor) else { return [] }
        return cities
    }
    
    func insertCities(_ cities: [CityCoordenates]) async {
        cities.forEach { context.insert($0) }
        try? context.save()
    }
    
    func insertCity(_ city: CityCoordenates) async {
        context.insert(city)
        try? context.save()
    }
    
    func deleteCity(_ city: CityCoordenates) async {
        context.delete(city)
        try? context.save()
    }
}
