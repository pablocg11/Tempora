
import SwiftUI

@main
struct TemporaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(weatherView: WeatherViewFactory().createView(),
                        savedCitiesView: SavedCitiesViewFactory().createView())
        }
    }
}
