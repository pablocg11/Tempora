
import Foundation

struct Coord: Hashable {
    let lon: Double
    let lat: Double
    
    init(lon: Double, lat: Double) {
        self.lon = lon
        self.lat = lat
    }
    
    init(dto: CoordDTO) {
        self.lon = dto.lon
        self.lat = dto.lat
    }
}
