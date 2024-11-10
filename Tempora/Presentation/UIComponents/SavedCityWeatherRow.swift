
import SwiftUI

struct SavedCityWeatherRow: View {
    @State var cityName: String
    var weatherResponse: WeatherResponse
    private let weatherIconManager = WeatherIconManager()
    private let backgroundManager = WeatherBackgroundManager()

    var body: some View {
        if let weather = weatherResponse.weather.first {
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading){
                        Text(cityName)
                            .font(.title)
                        
                        let hour = Date(timeIntervalSince1970: TimeInterval(weatherResponse.timezone))
                        Text(CustomHourFormatter.shared.string(from: hour))
                            .font(.callout)
                    }
                    
                    Spacer()
                    
                    Text("\(Int(weatherResponse.main.temp))ºC")
                        .font(.title)
                        .fontWeight(.light)
                }
                
                Spacer()
                
                HStack {
                    Text(weather.description)
                        .font(.callout)
                    
                    Spacer()
                    
                    Text("Max: \(Int(weatherResponse.main.tempMax))º Min: \(Int(weatherResponse.main.tempMin))º")
                        .font(.callout)
                }
                
            }
            .padding()
            .foregroundColor(.white)
            .background(backgroundManager.getBackgroundGradient(for: weather.description, timezone: weatherResponse.timezone))
            .cornerRadius(20)
            .frame(height: 120)
        }
    }
}


