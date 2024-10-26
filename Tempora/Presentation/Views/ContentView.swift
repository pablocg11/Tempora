
import SwiftUI

struct ContentView: View {
    
    private let weatherView: WeatherView
    
    init(weatherView: WeatherView) {
        self.weatherView = weatherView
    }
    
    var body: some View {
        TabView {
            weatherView
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            SavedCityWeatherView()
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
        }
        .accentColor(.blue)
    }
}


