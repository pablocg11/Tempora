import SwiftUI

struct WeatherCondition: View {
    let weatherResponse: WeatherResponse
    private let iconManager = WeatherIconManager()
    private let backgroundManager = WeatherBackgroundManager()
    
    var body: some View {
        if let weather = weatherResponse.weather.first {
            VStack {
                VStack(alignment: .leading) {
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text(weatherResponse.name)
                                .font(.title)
                                .fontWeight(.bold)
                            
                            let date = Date(timeIntervalSince1970: TimeInterval(weatherResponse.dt))
                            Text(CustomDateFormatter.shared.string(from: date))
                                .font(.callout)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // cambiar a star sin fill
                        }){
                            Image(systemName: "star.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 30, maxHeight: 30)
                                .foregroundColor(.yellow)
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                    HStack {
                        VStack {
                            Image(systemName: iconManager.getIcon(for: weather.description))
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 150, minHeight: 150)
                                .foregroundColor(Color(iconManager.getColor(for: weather.description)))
                            
                            Text(weather.description)
                                .font(.callout)
                                .fontWeight(.bold)
                        }
                        
                        Spacer()
                        
                        let roundedTemperature = Int(weatherResponse.main.temp.rounded())
                        Text("\(roundedTemperature)°C")
                            .font(.system(size: 60))
                    }
                    .padding()
                    
                    Spacer()
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Weather conditions")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            WeatherInfoItem(title: "Min temp",
                                            icon: "thermometer.low",
                                            info: Int(weatherResponse.main.temp_min),
                                            unit: "º")
                            
                            WeatherInfoItem(title: "Wind speed",
                                            icon: "wind",
                                            info: Int(weatherResponse.wind.speed),
                                            unit: "km/s")
                            
                            WeatherInfoItem(title: "Pressure",
                                            icon: "barometer",
                                            info: Int(weatherResponse.main.pressure),
                                            unit: "hPa")
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            WeatherInfoItem(title: "Max temp",
                                            icon: "thermometer.high",
                                            info: Int(weatherResponse.main.temp_max),
                                            unit: "º")
                            
                            WeatherInfoItem(title: "Humidity",
                                            icon: "humidity.fill",
                                            info: weatherResponse.main.humidity,
                                            unit: "º")
                            
                            WeatherInfoItem(title: "Visibility",
                                            icon: "eye.fill",
                                            info: (weatherResponse.visibility/1000),
                                            unit: "km")
                        }
                    }
                }
                .padding()
                .background(.white)
                .foregroundColor(Color.gray)
                .clipShape(
                    .rect(
                        topLeadingRadius: 10,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 10
                    )
                )
            }
            .ignoresSafeArea()
            .foregroundColor(.white)
            .background(backgroundManager.getBackgroundGradient(for: weather.description, timezone: weatherResponse.timezone))
        }
    }
}

