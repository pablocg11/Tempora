import SwiftUI

struct WeatherConditionItemsView: View {
    @State var selectedUnit: String
    @State var weatherResponse: WeatherResponse
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Weather conditions")
                .font(.headline)
                .fontWeight(.semibold)
            
            HStack {
                VStack(alignment: .leading) {
                    WeatherInfoItem(
                        title: "Min temp",
                        icon: "thermometer.low",
                        info: temperature(for: weatherResponse.main.tempMin),
                        unit: selectedUnit == "F" ? "ºF" : "ºC"
                    )
                    .transition(.opacity)
                    
                    WeatherInfoItem(
                        title: "Wind speed",
                        icon: "wind",
                        info: Int(weatherResponse.wind.speed),
                        unit: "km/h"
                    )
                    
                    WeatherInfoItem(
                        title: "Pressure",
                        icon: "barometer",
                        info: Int(weatherResponse.main.pressure),
                        unit: "hPa"
                    )
                    
                    let sunrise = weatherResponse.sys.sunrise
                    let sunriseDate = Date(timeIntervalSince1970: TimeInterval(sunrise))
                    let calendar = Calendar.current
                    let hour = calendar.component(.hour, from: sunriseDate)

                    WeatherInfoItem(
                        title: "Sunrise",
                        icon: "sunrise.fill",
                        info: hour,
                        unit: "h"
                    )
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    WeatherInfoItem(
                        title: "Max temp",
                        icon: "thermometer.high",
                        info: temperature(for: weatherResponse.main.tempMax),
                        unit: selectedUnit == "F" ? "ºF" : "ºC"
                    )
                    .transition(.opacity)

                    WeatherInfoItem(
                        title: "Humidity",
                        icon: "humidity.fill",
                        info: weatherResponse.main.humidity,
                        unit: "%"
                    )
                    
                    WeatherInfoItem(
                        title: "Visibility",
                        icon: "eye.fill",
                        info: (weatherResponse.visibility / 1000),
                        unit: "km"
                    )
                    
                    let sunset = weatherResponse.sys.sunset
                    let sunsetDate = Date(timeIntervalSince1970: TimeInterval(sunset))
                    let calendar = Calendar.current
                    let hour = calendar.component(.hour, from: sunsetDate)

                    WeatherInfoItem(
                        title: "Sunset",
                        icon: "sunset.fill",
                        info: hour,
                        unit: "h"
                    )

                }
            }
        }
        .padding()
        .background(.white)
        .foregroundColor(Color.gray)
        .cornerRadius(10)
    }
    
    private func temperature(for value: Double) -> Int {
        selectedUnit == "F" ? Int(value) : Int(value)
    }
    
    private func formattedDate(from timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        return CustomDateFormatter.shared.string(from: date)
    }
}
