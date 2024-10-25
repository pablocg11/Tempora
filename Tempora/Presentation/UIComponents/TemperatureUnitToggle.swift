
import SwiftUI

struct TemperatureUnitToggle: View {
    
    let units = ["ºC", "ºF"]
    @State private var selectedUnit = "ºC"
    
    var body: some View {
        HStack {
            ForEach(units, id: \.self) { unit in
                Button(action: {
                    selectedUnit = unit
                }) {
                    Text(unit)
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                        .background(selectedUnit == unit ? Color.white : Color.gray.opacity(0.1))
                        .foregroundColor(selectedUnit == unit ? Color.black : Color.black.opacity(0.2))
                        .cornerRadius(8)
                }
            }
        }
        .cornerRadius(10)
        .shadow(radius: 1)
    }
}

#Preview {
    TemperatureUnitToggle()
}
