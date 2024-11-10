
import SwiftUI

struct ErrorView: View {
    @State var errorMessage: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Image(systemName: "globe")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 100, maxHeight: 100)
            
            Text(errorMessage)
                .font(.callout)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
        }
        .foregroundColor(.gray)
    }
}

