
import Foundation

struct Sys: Hashable {
    let country: String
    let sunrise: Int
    let sunset: Int
    
    init(country: String, sunrise: Int, sunset: Int) {
        self.country = country
        self.sunrise = sunrise
        self.sunset = sunset
    }
    
    init(dto: SysDTO) {
        self.country = dto.country
        self.sunrise = dto.sunrise
        self.sunset = dto.sunset
    }
    
    func countryFlag() -> String {
        return country.uppercased().unicodeFlag
    }
}
