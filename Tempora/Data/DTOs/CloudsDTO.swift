
import Foundation

struct CloudsDTO: Codable {
    let all: Int
    
    init(all: Int) {
        self.all = all
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.all = try container.decode(Int.self, forKey: .all)
    }
}
