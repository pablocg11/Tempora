
import SwiftUI

struct SavedCityWeatherRow: View {
//    @State var cityName: String
//    @State var weatherResponse: WeatherResponse
//    private let weatherIconManager = WeatherIconManager()

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading){
                    Text("Madrid")
                        .font(.title)
                    Text("12:30")
                        .font(.callout)
                }
                
                Spacer()
                
                Text("25°C")
                    .font(.title)
                    .fontWeight(.light)
            }
            
            Spacer()

            HStack {
                Text("Mayormente nublado")
                    .font(.callout)
                
                Spacer()
                
                Text("Máx 26º Mín. 15º")
                    .font(.callout)
            }
            
        }
        .padding()
        .foregroundColor(.white)
        .background(Color.black)
        .cornerRadius(20)
        .frame(maxHeight: 150)
    }
}

#Preview {
    SavedCityWeatherRow()
}
