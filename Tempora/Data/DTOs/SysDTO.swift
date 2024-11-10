
import Foundation

struct SysDTO: Codable {
    let country: String
    let sunrise: Int
    let sunset: Int
    
    init(country: String, sunrise: Int, sunset: Int) {
        self.country = country
        self.sunrise = sunrise
        self.sunset = sunset
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.country = try container.decode(String.self, forKey: .country)
        self.sunrise = try container.decode(Int.self, forKey: .sunrise)
        self.sunset = try container.decode(Int.self, forKey: .sunset)
    }
}
