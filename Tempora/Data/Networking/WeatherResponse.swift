
import Foundation

struct WeatherResponse: Codable {
    let coord: Coordinate
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let rain: Rain?
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
    
    var isEmpty: Bool {
        return weather.isEmpty
    }
}
