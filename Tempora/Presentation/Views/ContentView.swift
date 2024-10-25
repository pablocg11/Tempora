
import SwiftUI

struct ContentView: View {
    
    @State private var location: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Introduce una localización",
                              text: $location)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Buscar") {
                        
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .navigationTitle("Tempora")
        }
    }
}

#Preview {
    ContentView()
}
