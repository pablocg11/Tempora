
import Foundation

protocol HTTPClientProtocol {
    func makeRequest(_ request: HTTPRequest) async -> Result<Data, HTTPClientError>
}

class HTTPClient: HTTPClientProtocol {
    let session: URLSession
    let errorsResolver: HTTPErrorsResolver
    let requestBuilder: HTTPRequestBuilder
    
    init(session: URLSession = .shared, requestBuilder: HTTPRequestBuilder, errorsResolver: HTTPErrorsResolver) {
        self.session = session
        self.errorsResolver = errorsResolver
        self.requestBuilder = requestBuilder
    }
    
    func makeRequest(_ request: HTTPRequest) async -> Result<Data, HTTPClientError> {
        guard let url = requestBuilder.url(request: request) else {
            return .failure(.badURL)
        }
        
        do {
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(.responseError)
            }
            
            guard httpResponse.statusCode == 200 else {
                return .failure(errorsResolver.resolve(errorCode: httpResponse.statusCode))
            }
            return .success(data)
            
        } catch {
            return .failure(errorsResolver.resolve(error: error))
        }
    }
}
