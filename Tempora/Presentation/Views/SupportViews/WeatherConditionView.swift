import SwiftUI

struct WeatherConditionView: View {
    let weatherResponse: WeatherResponse
    @Binding var selectedUnit: String
    private let iconManager = WeatherIconManager()
    
    var body: some View {
        if let weather = weatherResponse.weather.first {
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(weatherResponse.name)
                                .font(.title)
                                .fontWeight(.bold)
 
                            Text(formattedDate(from: weatherResponse.timezone))
                                .font(.callout)
                        }
                        Spacer()
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
                        
                        Text("\(temperature(for: weatherResponse.main.tempMax))º\(selectedUnit)")
                            .font(.system(size: 60))
                            .animation(.easeInOut, value: selectedUnit)

                    }
                    .padding()
                    
                    Spacer()
                }
                .padding()
                
                WeatherConditionItemsView(selectedUnit: selectedUnit,
                                          weatherResponse: weatherResponse)
            }
            .foregroundColor(.white)
            .background(Color.clear.opacity(0.7))
        }
    }
    
    private func temperature(for value: Double) -> Int {
        selectedUnit == "F" ? Int(value) : Int(value)
    }
    
    private func formattedDate(from timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        return CustomDateFormatter.shared.string(from: date)
    }
}

