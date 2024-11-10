
import Foundation

struct Wind {
    let speed: Double
    let deg: Int
    let gust: Double?
    
    init(speed: Double, deg: Int, gust: Double) {
        self.speed = speed
        self.deg = deg
        self.gust = gust
    }
    
    init(dto: WindDTO) {
        self.speed = dto.speed
        self.deg = dto.deg
        self.gust = dto.gust
    }
    
    func windDirection() -> String {
        switch deg {
        case 0...22:
            return "North"
        case 23...67:
            return "Northeast"
        case 68...112:
            return "East"
        case 113...157:
            return "Southeast"
        case 158...202:
            return "South"
        case 203...247:
            return "Southwest"
        case 248...292:
            return "West"
        case 293...337:
            return "Northwest"
        default:
            return "North" 
        }
    }
}
