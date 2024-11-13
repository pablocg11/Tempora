
import SwiftUI

struct TemperatureUnitToggle: View {
    let units = ["C", "F"]
    @Binding var selectedUnit: String
    
    var body: some View {
        HStack {
            ForEach(units, id: \.self) { unit in
                Button(action: {
                    selectedUnit = unit
                }) {
                    Text("º\(unit)")
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                        .background(selectedUnit == unit ? Color.blue : Color.gray.opacity(0.2))
                        .foregroundColor(selectedUnit == unit ? Color.white : Color.black.opacity(0.5))
                        .cornerRadius(8)
                }
            }
        }
        .padding(5)
        .background(.white.opacity(0.6))
        .cornerRadius(10)
    }
}

