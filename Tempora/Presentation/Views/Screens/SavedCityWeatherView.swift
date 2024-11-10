import SwiftUI

struct SavedCityWeatherView: View {
    
    @ObservedObject var viewModel: SavedCitiesViewModel
    
    init(viewModel: SavedCitiesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
       NavigationView {
           
           if viewModel.showLoading {
               ProgressView()
           }
           else{
               if $viewModel.savedCitiesWeather.isEmpty {
                   VStack(alignment: .center, spacing: 20) {
                       Image(systemName: "list.bullet")
                           .resizable()
                           .scaledToFit()
                           .frame(maxWidth: 100, maxHeight: 100)
                       
                       Text("No saved cities. Please add some.")
                           .font(.callout)
                           .fontWeight(.semibold)
                           .multilineTextAlignment(.center)
                   }
                   .foregroundColor(.gray)
               } else {
                   VStack(alignment: .leading) {
                       Text("Your cities")
                           .font(.headline)
                           .fontWeight(.light)
                           .padding(.horizontal)
                       
//                       ScrollView(showsIndicators: false) {
//                           VStack {
//                               ForEach(viewModel.savedCitiesWeather, id: \.id) { cityWeather in
//                                   Button(action: {
//                                       viewModel.deleteSavedCity(cityWeather.coordinates)
//                                   }) {
//                                       SavedCityWeatherRow(cityName: cityWeather.coordinates.name,
//                                                           weatherResponse: cityWeather.weather)
//                                   }
//                               }
//                           }
//                       }
//                       .padding(10)
                   }
               }
           }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}
