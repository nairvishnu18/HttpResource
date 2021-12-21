import Foundation

public struct HttpResource {
    public init() {}
    
    @available(macOS 10.15.0, *)
    @available(macOS 12.0, *)

    /// Generic Async function to decode json data from given url request.
    ///  - Parameters:
    ///   - urlRequest: url of the server api
    ///   - responseType: Type of model by which json data is to be decoded
    ///  - Returns: Decoded json data
    public func getJsonData<T: Decodable>(from urlRequest: URLRequest, forResponseType responseType: T.Type) async throws -> T {
        
        do {
            let (responseData,responseCode) = try await URLSession.shared.data(for: urlRequest)
            guard let httpSuccessCode = (responseCode as? HTTPURLResponse)?.statusCode, (200...299).contains(httpSuccessCode) else {
                throw HttpError.nonSuccessStatusCode
            }
            
            let jsonData = try JSONDecoder().decode(responseType.self, from: responseData)
            
            return jsonData
            
        } catch  {
            throw error
        }
    }
}
