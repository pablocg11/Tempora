
import Foundation

struct Weather: Codable {
    let id: Int
    let description: String
    let icon: String
    var weatherIcon: URL {
        let urlString = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        return URL(string: urlString)!
    }
}
