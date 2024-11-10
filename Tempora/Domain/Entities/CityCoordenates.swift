
import Foundation
import SwiftData

@Model
class CityCoordenates {
    @Attribute(.unique) var id: UUID
    var lat: Double
    var lon: Double
    
    init(id: UUID = UUID(), lat: Double, lon: Double) {
        self.id = id
        self.lat = lat
        self.lon = lon
    }
}
