
import Foundation

struct CoordDTO: Codable {
    let lon: Double
    let lat: Double
    
    init(lon: Double, lat: Double) {
        self.lon = lon
        self.lat = lat
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lon = try container.decode(Double.self, forKey: .lon)
        self.lat = try container.decode(Double.self, forKey: .lat)
    }
}
