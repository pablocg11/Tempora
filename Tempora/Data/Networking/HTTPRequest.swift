
import Foundation

struct HTTPRequest {
    let baseURL: String
    let queryParams: [String: Any]?
    let method: HTTPMethod
    
    init(baseURL: String, method: HTTPMethod, queryParams: [String : Any]? = nil) {
        self.baseURL = baseURL
        self.queryParams = queryParams
        self.method = method
    }
}
