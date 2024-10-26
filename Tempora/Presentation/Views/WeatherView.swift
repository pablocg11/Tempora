import SwiftUI

struct WeatherView: View {
    @State private var location: String = ""
    @ObservedObject var viewModel: WeatherViewModel
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        fetchWeather(for: "Madrid")
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    HStack {
                        TextField("Enter a location", text: $location)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button("Search") {
                            if !location.isEmpty {
                                fetchWeather(for: location)
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
                    } else if let errorMessage = viewModel.errorMessage {
                        VStack(alignment: .center, spacing: 20) {
                            Image(systemName: "globe")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 100, maxHeight: 100)
                            
                            Text(errorMessage)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                        }
                    } else if let weather = viewModel.weather {
                        withAnimation {
                            WeatherCondition(weatherResponse: weather)
                        }
                    }
                    
                    Spacer()
                }
            }
        }
    }
    
    private func fetchWeather(for location: String) {
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
