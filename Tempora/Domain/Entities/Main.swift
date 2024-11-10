
import Foundation

struct Main {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
    let seaLevel: Int
    let grndLevel: Int
    
    init(temp: Double, feelsLike: Double, tempMin: Double, tempMax: Double, pressure: Int, humidity: Int, seaLevel: Int, grndLevel: Int) {
        self.temp = temp
        self.feelsLike = feelsLike
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.pressure = pressure
        self.humidity = humidity
        self.seaLevel = seaLevel
        self.grndLevel = grndLevel
    }
    
    init(dto: MainDTO) {
        self.temp = dto.temp
        self.feelsLike = dto.feelsLike
        self.tempMin = dto.tempMin
        self.tempMax = dto.tempMax
        self.pressure = dto.pressure
        self.humidity = dto.humidity
        self.seaLevel = dto.seaLevel
        self.grndLevel = dto.grndLevel
    }
    
    func tempInCelsius() -> Double {
        return temp - 273.15
    }
    
    func tempInFahrenheit() -> Double {
        return (temp - 273.15) * 9/5 + 32
    }
    
    func feelsLikeInCelsius() -> Double {
        return feelsLike - 273.15
    }
    
    func tempMinInCelsius() -> Double {
        return tempMin - 273.15
    }
    
    func tempMaxInCelsius() -> Double {
        return tempMax - 273.15
    }
    
    func feelsLikeInFahrenheit() -> Double {
        return (feelsLike - 273.15) * 9/5 + 32
    }
    
    func tempMinInFahrenheit() -> Double {
        return (tempMin - 273.15) * 9/5 + 32
    }
    
    func tempMaxInFahrenheit() -> Double {
        return (tempMax - 273.15) * 9/5 + 32
    }
}
