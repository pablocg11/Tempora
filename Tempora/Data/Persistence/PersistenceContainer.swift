
import Foundation
import SwiftData

class PersistenceContainer: PersistenceContainerProtocol {
    
    static let sharedInstance = PersistenceContainer()
        
    private let container: ModelContainer
    private let context: ModelContext
    
    private init() {
        let schema = Schema([CityCoordenates.self])
        do {
            container = try ModelContainer(for: schema, configurations: [])
            context = ModelContext(container)
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }
    
    static func shared() -> PersistenceContainer {
        return sharedInstance
    }
    
    func fetchSavedCities() -> Result<[CityCoordenates], DomainError> {
        let descriptor = FetchDescriptor<CityCoordenates>()
        
        do {
            let cities = try context.fetch(descriptor)
            return .success(cities)
        } catch {
            return .failure(.persistenceError(error)) 
        }
    }
    
    func saveCity(_ city: CityCoordenates) async -> Result<Void, DomainError> {
        context.insert(city)
        
        do {
            try context.save()
            return .success(())
        } catch {
            return .failure(.persistenceError(error))
        }
    }
    
    func deleteCity(_ city: CityCoordenates) async -> Result<Void, DomainError> {
            context.delete(city)
            
            do {
                try context.save()
                return .success(())
            } catch {
                return .failure(.persistenceError(error))
            }
        }
}
