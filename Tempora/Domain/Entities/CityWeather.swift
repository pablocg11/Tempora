
import Foundation

struct CityWeather: Hashable, Equatable {
    let city: CityCoordenates
    let weather: WeatherResponse
    
    static func == (lhs: CityWeather, rhs: CityWeather) -> Bool {
        return lhs.city == rhs.city
    }
}
