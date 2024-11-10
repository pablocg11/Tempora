
import SwiftUI

struct ContentView: View {
    
    private let weatherView: WeatherView
    private let savedCityWeatherView: SavedCityWeatherView
    
    init(weatherView: WeatherView, savedCityWeatherView: SavedCityWeatherView) {
        self.weatherView = weatherView
        self.savedCityWeatherView = savedCityWeatherView
    }
    
    var body: some View {
        TabView {
            weatherView
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            savedCityWeatherView
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
        }
        .accentColor(.blue)
    }
}


