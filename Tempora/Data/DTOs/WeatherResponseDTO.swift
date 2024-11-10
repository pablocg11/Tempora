
import Foundation

struct WeatherResponseDTO: Codable {
    let coord: CoordDTO
    let weather: [WeatherDTO]
    let base: String
    let main: MainDTO
    let visibility: Int
    let wind: WindDTO
    let clouds: CloudsDTO
    let dt: Int
    let sys: SysDTO
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}
