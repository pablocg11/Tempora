
import Foundation

struct WindDTO: Codable {
    let speed: Double
    let deg: Int
    let gust: Double?
    
    init(speed: Double, deg: Int, gust: Double) {
        self.speed = speed
        self.deg = deg
        self.gust = gust
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.speed = try container.decode(Double.self, forKey: .speed)
        self.deg = try container.decode(Int.self, forKey: .deg)
        self.gust = try container.decodeIfPresent(Double.self, forKey: .gust) 
    }
}
