
import Foundation
import SwiftData

@Model
class CityCoordenates: Identifiable {
    @Attribute(.unique) var id: UUID
    var name: String
    var lat: Double
    var lon: Double
    
    init(id: UUID = UUID(), name: String, lat: Double, lon: Double) {
        self.id = id
        self.name = name
        self.lat = lat
        self.lon = lon
    }
}
