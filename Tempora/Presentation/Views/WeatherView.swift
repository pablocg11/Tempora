import SwiftUI

struct WeatherView: View {
    @State private var location: String = ""
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                
                // TemperatureUnitToggle()
                
                HStack {
                    TextField("Enter a location", text: $location)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Search") {
                        if !location.isEmpty {
                            fetchWeather()
                            location = ""
                        }
                    }
                    .disabled(location.isEmpty)
                }
                .padding()
                
                Spacer()
                
                if viewModel.showLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                        .scaleEffect(1.5)
                        .frame(width: 60, height: 60)
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.vertical)
                } else if let weather = viewModel.weather {
                    WeatherCondition(weatherResponse: weather)
                }
                
                Spacer()
            }
        }
    }
    
    private func fetchWeather() {
        viewModel.getLatAndLongFromLocation(location: location) { result in
            switch result {
            case .success(let (lat, lon)):
                viewModel.requestCurrentWeather(forLat: lat, forLon: lon)
            case .failure(let error):
                viewModel.handleError(error)
            }
        }
    }
}
