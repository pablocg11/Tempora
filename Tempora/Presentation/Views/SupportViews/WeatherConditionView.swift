import SwiftUI

struct WeatherConditionView: View {
    let weatherResponse: WeatherResponse
    @Binding var selectedUnit: String
    @ObservedObject var cityCoordenatesViewModel: CityCoordenatesViewModel
    @State private var isFavorite: Bool = false
    
    init(weatherResponse: WeatherResponse, selectedUnit: Binding<String>, cityCoordenatesViewModel: CityCoordenatesViewModel) {

        self.weatherResponse = weatherResponse
        self._selectedUnit = selectedUnit
        self.cityCoordenatesViewModel = cityCoordenatesViewModel
        
        let city = CityCoordenates(name: weatherResponse.name, lat: weatherResponse.coord.lat, lon: weatherResponse.coord.lon)
        self._isFavorite = State(initialValue: cityCoordenatesViewModel.isCityFavorite(city))
    }
    
    var body: some View {
        if let weather = weatherResponse.weather.first {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(weatherResponse.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(formattedDate(from: weatherResponse.dt))
                            .font(.callout)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        toggleFavorite()
                    }) {
                        Image(systemName: isFavorite ? "star.fill" : "star")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 30, maxHeight: 30)
                            .foregroundColor(weatherResponse.checkIfDay() ? .white : .yellow)
                            .padding(.horizontal)
                    }
                }
                
                Spacer()
                
                HStack {
                    VStack {
                        Image(systemName: weather.getIcon(isDay: weatherResponse.checkIfDay()))
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 140, minHeight: 120)
                            .foregroundColor(Color(weather.getIconColor(isDay: weatherResponse.checkIfDay())))
                        
                        Text(weather.description)
                            .font(.callout)
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                    
                    ZStack {
                        if selectedUnit == "C" {
                            Text("\(Int(weatherResponse.main.tempInCelsius()))º\(selectedUnit)")
                                .font(.system(size: 60))
                                .transition(.opacity)
                        } else {
                            Text("\(Int(weatherResponse.main.tempInFahrenheit()))º\(selectedUnit)")
                                .font(.system(size: 60))
                                .transition(.opacity)
                        }
                    }
                    .animation(.easeInOut, value: selectedUnit)
                }
                .padding([.horizontal, .bottom])
                
                WeatherConditionItemsView(selectedUnit: $selectedUnit,
                                          weatherResponse: weatherResponse)
            }
            .foregroundColor(.white)
        }
    }
    
    private func toggleFavorite(){
        let city = CityCoordenates(name: weatherResponse.name, lat: weatherResponse.coord.lat, lon: weatherResponse.coord.lon)
        
        Task {
            if isFavorite {
//                await cityCoordenatesViewModel.removeCityFromFavorites(city)
                print("Hola")
            } else {
                 await cityCoordenatesViewModel.saveCityCoordenates(city)
            }
            isFavorite.toggle()
        }
    }
    
    private func formattedDate(from timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        return CustomDateFormatter.shared.string(from: date)
    }
}

