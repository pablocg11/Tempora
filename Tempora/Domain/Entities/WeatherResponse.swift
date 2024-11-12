import Foundation

struct WeatherResponse: Hashable, Equatable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
    
    var isEmpty: Bool {
        return weather.isEmpty
    }
    
    init(coord: Coord, weather: [Weather], base: String, main: Main, visibility: Int, wind: Wind, clouds: Clouds, dt: Int, sys: Sys, timezone: Int, id: Int, name: String, cod: Int) {
        self.coord = coord
        self.weather = weather
        self.base = base
        self.main = main
        self.visibility = visibility
        self.wind = wind
        self.clouds = clouds
        self.dt = dt
        self.sys = sys
        self.timezone = timezone
        self.id = id
        self.name = name
        self.cod = cod
    }
    
    init(dto: WeatherResponseDTO) {
        self.coord = Coord(dto: dto.coord)
        self.weather = dto.weather.map { Weather(dto: $0) }
        self.base = dto.base
        self.main = Main(dto: dto.main)
        self.visibility = dto.visibility
        self.wind = Wind(dto: dto.wind)
        self.clouds = Clouds(dto: dto.clouds)
        self.dt = dto.dt
        self.sys = Sys(dto: dto.sys)
        self.timezone = dto.timezone
        self.id = dto.id
        self.name = dto.name
        self.cod = dto.cod
    }
    
    func checkIfDay() -> Bool {
        let currentDate = Date()
        let hour = Calendar.current.component(.hour, from: currentDate)
        
        let localHour = (hour + self.timezone / 3600) % 24
        return localHour >= 7 && localHour < 19
    }
    
    static func == (lhs: WeatherResponse, rhs: WeatherResponse) -> Bool {
        return lhs.weather == rhs.weather
    }
}
