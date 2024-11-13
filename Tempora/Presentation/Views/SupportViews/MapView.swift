
import SwiftUI
import MapKit

struct MapView: View {
    @State var cityCoordenates: CityCoordenates
    @State private var region: MKCoordinateRegion
    
    
    init(cityCoordenates: CityCoordenates) {
        self.cityCoordenates = cityCoordenates
        
        self._region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: cityCoordenates.lat,
                                           longitude: cityCoordenates.lon),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        ))
    }
    
    var body: some View {
        Map(coordinateRegion: $region, interactionModes: .all,
            annotationItems: [cityCoordenates]) {_ in
            MapPin(coordinate: CLLocationCoordinate2D(latitude: cityCoordenates.lat,
                                                      longitude: cityCoordenates.lon))
        }
            .frame(height: 300)
            .cornerRadius(10)
    }
}

#Preview {
    MapView(cityCoordenates: CityCoordenates(id: UUID(),
                                             name: "Madrid",
                                             lat: 40.4165,
                                             lon: -3.70256))
}

