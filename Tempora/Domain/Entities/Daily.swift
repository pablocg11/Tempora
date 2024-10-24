
import Foundation

struct Daily: Codable {
    let dt: Date
    let temp: Temp
    let humidity: Int
    let weather: [Weather]
    let clouds: Int
    let pop: Double
}
