
import SwiftUI
import MapKit

struct MapView: View {
    @State var cityCoordenates: CityCoordenates
    
    var body: some View {
        Map() {
            Marker(cityCoordenates.name,
                   systemImage: "pin.fill",
                   coordinate: CLLocationCoordinate2D(latitude: self.cityCoordenates.lat,
                                                      longitude: self.cityCoordenates.lon))
            .tint(.blue)
        }
        .cornerRadius(10)
    }
}

#Preview {
    MapView(cityCoordenates: CityCoordenates(id: UUID(),
                                             name: "Madrid",
                                             lat: 40.4165,
                                             lon:  -3.70256))
}

