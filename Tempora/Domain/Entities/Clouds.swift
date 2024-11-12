
import Foundation

struct Clouds: Hashable {
    let all: Int
    
    init(all: Int) {
        self.all = all
    }
    
    init(dto: CloudsDTO) {
        self.all = dto.all
    }
}
