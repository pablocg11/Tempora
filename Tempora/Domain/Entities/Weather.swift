
import SwiftUI
import Foundation

struct Weather: Hashable, Equatable {
    let id: Int
    let main: String
    let description: String
    let icon: String

    init(id: Int, main: String, description: String, icon: String) {
        self.id = id
        self.main = main
        self.description = description
        self.icon = icon
    }
    
    init(dto: WeatherDTO) {
        self.id = dto.id
        self.main = dto.main
        self.description = dto.description
        self.icon = dto.icon
    }
    
    func getGradient(isDay: Bool) -> LinearGradient {
        let gradientColors: [Color]
        
        switch self.description.lowercased() {
        case "clear sky":
            gradientColors = isDay ? [Color.blue, Color.cyan] : [Color.black, Color.blue.opacity(0.3)]
        case "few clouds":
            gradientColors = isDay ? [Color.yellow, Color.orange] : [Color.gray, Color.blue.opacity(0.2)]
        case "scattered clouds":
            gradientColors = isDay ? [Color.gray.opacity(0.6), Color.blue.opacity(0.4)] : [Color.gray, Color.black.opacity(0.7)]
        case "broken clouds":
            gradientColors = isDay ? [Color.gray, Color.gray.opacity(0.5)] : [Color.gray.opacity(0.8), Color.black]
        case "shower rain", "rain", "moderate rain", "heavy intensity rain":
            gradientColors = isDay ? [Color.blue.opacity(0.7), Color.gray] : [Color.blue.opacity(0.4), Color.black]
        case "thunderstorm":
            gradientColors = isDay ? [Color.purple, Color.blue.opacity(0.5)] : [Color.purple, Color.black.opacity(0.7)]
        case "snow":
            gradientColors = isDay ? [Color.white, Color.blue.opacity(0.6)] : [Color.white.opacity(0.8), Color.black]
        case "mist":
            gradientColors = isDay ? [Color.gray.opacity(0.4), Color.blue.opacity(0.3)] : [Color.gray, Color.black.opacity(0.5)]
        case "haze":
            gradientColors = isDay ? [Color.gray.opacity(0.4), Color.blue.opacity(0.3)] : [Color.gray, Color.black.opacity(0.5)]
        default:
            gradientColors = isDay ? [Color.blue, Color.cyan] : [Color.black, Color.gray]
        }
               
        return LinearGradient(
            gradient: Gradient(colors: gradientColors),
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    func getIcon(isDay: Bool) -> String {
        
        switch self.description.lowercased() {
        case "clear sky":
            return isDay ? "sun.max.fill" : "moon.fill"
        case "few clouds":
            return isDay ? "cloud.sun.fill" : "cloud.moon.fill"
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
        case "moderate rain", "heavy intensity rain":
            return "cloud.rain.fill"
        case "thunderstorm":
            return "cloud.bolt.rain.fill"
        case "snow":
            return "snowflake"
        case "mist":
            return "cloud.fog.fill"
        case "haze":
            return "sun.haze.fill"
        default:
            return "questionmark.circle"
        }
    }
    
    func getIconColor(isDay: Bool) -> Color {
        
        switch self.description.lowercased() {
        case "clear sky":
            return isDay ? Color.yellow : Color.white
        case "few clouds":
            return Color.gray.opacity(0.8)
        case "scattered clouds":
            return Color.gray.opacity(0.6)
        case "broken clouds", "overcast clouds":
            return Color.gray
        case "shower rain":
            return Color.gray.opacity(0.5)
        case "rain":
            return Color.gray.opacity(0.7)
        case "light rain", "moderate rain", "heavy intensity rain":
            return Color.gray.opacity(0.3)
        case "thunderstorm":
            return Color.yellow
        case "snow":
            return Color.white
        case "mist", "haze":
            return Color.gray.opacity(0.4)
        default:
            return Color.black
        }
    }
}
