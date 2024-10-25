
import Foundation

struct Rain: Codable {
    let oneHour: Double

    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
    }
}
