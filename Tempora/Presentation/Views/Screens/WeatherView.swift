import SwiftUI

struct WeatherView: View {
    @State private var location: String = ""
    @ObservedObject var vm: WeatherViewModel
    private let backgroundManager = WeatherBackgroundManager()
    
    init(vm: WeatherViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter a location", text: $location)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Search") {
                        if !location.isEmpty {
                                vm.getLatAndLongFromLocation(location: location) { result in
                                    switch result {
                                    case .success(let coordinates):
                                        let lat = coordinates.0
                                        let lon = coordinates.1

                                        vm.requestCurrentWeatherFromLocation(forLat: lat, forLon: lon)
                                        
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
                
                if vm.showLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                        .scaleEffect(1.5)
                } else if let errorMessage = vm.errorMessage {
                    ErrorView(errorMessage: errorMessage)
                } else if let weather = vm.weather {
                    if (weather.weather.first?.description) != nil {
                        VStack {
                            TemperatureUnitToggle(selectedUnit: $vm.selectedUnit)
                            WeatherConditionView(weatherResponse: weather,
                                             selectedUnit: $vm.selectedUnit)
                            .ignoresSafeArea(edges: .bottom)
                        }
                    }
                }
                
                Spacer()
            }
            .onAppear {
                vm.onAppear()
            }
            .background(
                Group {
                    if let weather = vm.weather,
                       let weatherDescription = weather.weather.first?.description {
                        backgroundManager.getBackgroundGradient(for: weatherDescription, timezone: weather.timezone)
                    } else {
                        Color.clear
                    }
                }
                .ignoresSafeArea(edges: .top)
            )
        }
    }
}
