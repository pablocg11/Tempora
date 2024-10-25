
import SwiftUI

struct ContentView: View {
    
    private let weatherView: WeatherView
    
    init(weatherView: WeatherView) {
        self.weatherView = weatherView
    }
    
    var body: some View {  
        weatherView
    }
}


