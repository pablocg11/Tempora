
import Foundation

struct Weather {
    let id: Int
    let main: String
    let description: String
    let icon: String

    init(id: Int, main: String, description: String, icon: String) {
        self.id = id
        self.main = main
        self.description = description
        self.icon = icon
    }
    
    init(dto: WeatherDTO) {
        self.id = dto.id
        self.main = dto.main
        self.description = dto.description
        self.icon = dto.icon
    }
}
