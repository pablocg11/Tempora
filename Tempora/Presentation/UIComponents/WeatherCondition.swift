import SwiftUI

struct WeatherCondition: View {
    let weatherResponse: WeatherResponse
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(weatherResponse.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                let date = Date(timeIntervalSince1970: TimeInterval(weatherResponse.dt))
                Text(CustomDateFormatter.shared.string(from: date))
                    .font(.callout)
                
                Spacer()
                
                if let weather = weatherResponse.weather.first {
                    HStack {
                        VStack {
                            //ICONO
                            
                            Text(weather.main)
                                .font(.callout)
                        }
                        Spacer()
                        
                        let roundedTemperature = Int(weatherResponse.main.temp.rounded())
                        Text("\(roundedTemperature)°C")
                            .font(.system(size: 60))
                    }
                }
                
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
        .background(Color.black)
    }
}

