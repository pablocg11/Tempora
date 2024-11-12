import SwiftUI

struct WeatherView: View {
    @State private var location: String = ""
    @ObservedObject var weatherViewModel: WeatherViewModel
    @ObservedObject var cityCoordenatesViewModel: CityCoordenatesViewModel
    
    init(weatherViewModel: WeatherViewModel,
         cityCoordenatesViewModel: CityCoordenatesViewModel) {
        self.weatherViewModel = weatherViewModel
        self.cityCoordenatesViewModel = cityCoordenatesViewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter a location", text: $location)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Search") {
                        if !location.isEmpty {
                            weatherViewModel.getLatAndLongFromLocation(location: location) { result in
                                    switch result {
                                    case .success(let coordinates):
                                        let lat = coordinates.0
                                        let lon = coordinates.1

                                        weatherViewModel.requestCurrentWeatherFromLocation(forLat: lat, forLon: lon)
                                    case .failure(let error):
                                        print("Error obteniendo coordenadas: \(error)")
                                    }
                                }
                                location = ""
                            }
                    }
                    .disabled(location.isEmpty)
                }
                .padding()
                
                Spacer()
                
                if weatherViewModel.showLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                        .scaleEffect(1.5)
                } else if let errorMessage = weatherViewModel.errorMessage {
                    ErrorView(errorMessage: errorMessage)
                } else if let weather = weatherViewModel.weather {
                    if (weather.weather.first?.description) != nil {
                        VStack {
                            TemperatureUnitToggle(selectedUnit: $weatherViewModel.selectedUnit)
                            WeatherConditionView(weatherResponse: weather,
                                                 selectedUnit: $weatherViewModel.selectedUnit,
                                                 cityCoordenatesViewModel: cityCoordenatesViewModel)
                        }
                    }
                }
                
                Spacer()
            }
            .onAppear {
                weatherViewModel.onAppear()
            }
            .background(
                Group {
                    if let weatherResponse = weatherViewModel.weather, let weather = weatherResponse.weather.first {
                        weather.getGradient(isDay: weatherResponse.checkIfDay())
                    } else {
                        Color.clear
                    }
                }
                    .ignoresSafeArea(edges: .top)
            )
        }
    }
}
