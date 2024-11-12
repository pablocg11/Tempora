import SwiftUI

struct SavedCitiesView: View {
    @ObservedObject var viewModel: CityCoordenatesViewModel
    
    init(viewModel: CityCoordenatesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
       NavigationView {
           
           if viewModel.showLoading {
               ProgressView()
           }
           else{
               if viewModel.cities.isEmpty {
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
                       
                       ForEach(viewModel.cities, id: \.self) { city in
                           Text(city.name)
                       }
                       
//                       ScrollView(showsIndicators: false) {
//                           VStack {
//                               ForEach(viewModel.savedCitiesWeather, id: \.self) { cityWeather in
//                                   SavedCityWeatherRow(cityName: cityWeather.city.name,
//                                                       weatherResponse: cityWeather.weather)
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
