
import SwiftUI

struct SavedCityWeatherView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Section("Your cities") {
                ScrollView(showsIndicators: false) {
                    ForEach(1...10, id: \.self) {_ in
                        Button(action: {
                            
                        }){
                            SavedCityWeatherRow()
                        }                        
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    SavedCityWeatherView()
}
