
import Foundation

protocol AddSavedCityUseCaseType {
    func execute(add weatherResponse: WeatherResponse) async -> Void
}
