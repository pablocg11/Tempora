import SwiftUI
import Foundation

class WeatherBackgroundManager {
    
    func getBackgroundGradient(for condition: String, timezone: Int) -> LinearGradient {
        let isDay = checkIfDay(in: timezone)
        
        let gradientColors: [Color]
        
        switch condition.lowercased() {
        case "clear sky":
            gradientColors = isDay ? [Color.blue, Color.cyan] : [Color.black, Color.blue.opacity(0.3)]
        case "few clouds":
            gradientColors = isDay ? [Color.yellow, Color.orange] : [Color.gray, Color.blue.opacity(0.2)]
        case "scattered clouds":
            gradientColors = isDay ? [Color.gray.opacity(0.6), Color.blue.opacity(0.4)] : [Color.gray, Color.black.opacity(0.7)]
        case "broken clouds":
            gradientColors = isDay ? [Color.gray, Color.gray.opacity(0.5)] : [Color.gray.opacity(0.8), Color.black]
        case "shower rain", "rain":
            gradientColors = isDay ? [Color.blue.opacity(0.7), Color.gray] : [Color.blue.opacity(0.4), Color.black]
        case "thunderstorm":
            gradientColors = isDay ? [Color.purple, Color.blue.opacity(0.5)] : [Color.purple, Color.black.opacity(0.7)]
        case "snow":
            gradientColors = isDay ? [Color.white, Color.blue.opacity(0.6)] : [Color.white.opacity(0.8), Color.black]
        case "mist":
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
    
    private func checkIfDay(in timezone: Int) -> Bool {
        let currentDate = Date()
        let hour = Calendar.current.component(.hour, from: currentDate)
        
        let localHour = (hour + timezone / 3600) % 24
        return localHour >= 6 && localHour < 18
    }
}
