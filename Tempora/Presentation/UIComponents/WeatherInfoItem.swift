import SwiftUI

struct WeatherInfoItem: View {
    
    @State private var title: String
    @State private var icon: String
    @State private var info: Int
    @State private var unit: String
    
    init(title: String, icon: String, info: Int, unit: String) {
        self.title = title
        self.icon = icon
        self.info = info
        self.unit = unit
    }
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 20, maxHeight: 20)
                .padding(15)
                .background(Color.gray.opacity(0.1))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(.caption)
                if info != 0 {
                    Text("\(info) \(unit)")
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
                else {
                    Text("\(unit)")
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
            }
            .padding(.horizontal,5)
        }
    }
}

