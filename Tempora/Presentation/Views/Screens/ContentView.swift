
import SwiftUI

struct ContentView: View {
    
    private let weatherView: WeatherView
    private let savedCitiesView: SavedCitiesView
    
    init(weatherView: WeatherView,
         savedCitiesView: SavedCitiesView) {
        self.weatherView = weatherView
        self.savedCitiesView = savedCitiesView
    }
    
    var body: some View {
        TabView {
            weatherView
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            savedCitiesView
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
        }
        .accentColor(.blue)
    }
}


