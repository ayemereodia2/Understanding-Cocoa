import Foundation

protocol ServiceApi {
     func getImageLinks(searchString: String?, pageNumber: Int?, completion: @escaping ((Result<PixarImage, PixarError>) -> Void))
}


class PixarBayApi: ServiceApi {
    private static let apiKey = "27855997-76f6e22bf078dd6de3ad2bf6d"
    
     func getImageLinks(searchString: String?, pageNumber: Int?, completion: @escaping ((Result<PixarImage, PixarError>) -> Void)) {
        guard let searchString = searchString,
              let pageNumber = pageNumber,
              let url = PixarBayApi.buildUrl(search: searchString, page: pageNumber) else {
            completion(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data,response, error in
            guard error == nil else {
                completion(.failure(.dataResponseError))
                return
            }
            guard let data = data else {
                completion(.failure(.dataResponseError))
                return
            }
            
            do {
                let imageData = try JSONDecoder().decode(PixarImage.self, from: data)
                completion(.success(imageData))
                
            } catch (let error) {
                completion(.failure(.jsonDecoderError(error: error)))
            }

        }.resume()
    }
    
    private static func buildUrl(search query: String,
                                 page: Int) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "pixabay.com"
        components.path = "/api/"
        components.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "message_type", value: "photo"),
            URLQueryItem(name: "page", value: "\(page)"),
        ]
        guard let url = components.url else { return nil }
        return url
    }
}

enum PixarError: Error {
    case urlError
    case dataResponseError
    case jsonDecoderError(error: Error)
}
