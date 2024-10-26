
import Foundation
import SwiftUI

class WeatherIconManager {
    
    func getIcon(for condition: String) -> String {
        switch condition {
        case "clear sky":
            return "sun.max.fill"
        case "few clouds":
            return "cloud.sun.fill"
        case "scattered clouds":
            return "cloud.fill"
        case "broken clouds":
            return "smoke.fill"
        case "overcast clouds":
            return "cloud.fill"
        case "shower rain":
            return "cloud.rain.fill"
        case "rain":
            return "cloud.heavyrain.fill"
        case "light rain":
            return "cloud.drizzle.fill"
        case "thunderstorm":
            return "cloud.bolt.rain.fill"
        case "snow":
            return "snowflake"
        case "mist":
            return "cloud.fog.fill"
        default:
            return "questionmark.circle"
        }
    }
    
    func getColor(for condition: String) -> Color {
        switch condition {
        case "clear sky":
            return Color.yellow
        case "few clouds":
            return Color.gray.opacity(0.8)
        case "scattered clouds":
            return Color.gray.opacity(0.6)
        case "broken clouds":
            return Color.gray
        case "overcast clouds":
            return Color.gray
        case "shower rain":
            return Color.blue.opacity(0.5)
        case "rain":
            return Color.blue.opacity(0.7)
        case "light rain":
            return Color.blue.opacity(0.3)
        case "thunderstorm":
            return Color.yellow
        case "snow":
            return Color.white
        case "mist":
            return Color.gray.opacity(0.4)
        default:
            return Color.black               
        }
    }
}
