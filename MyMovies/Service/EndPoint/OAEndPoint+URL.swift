
import Foundation

extension OAEndpoint {
    
    var url: URL {
        var baseUrl = OAHost.base
        return URL(string: baseUrl.url + endPoint)!
    }

    var endPoint : String {
        return switch self {
        case .fetchMovies(let apiKey): "/3/discover/movie?api_key=\(apiKey)"
        case .fetchMovieDetails(id: let id, apiKey: let apiKey):
            "/3/movie/\(id)?api_key=\(apiKey)"
        case .searchMovies(let query, apiKey: let apiKey):
            "/3/search/movie?api_key=\(apiKey)&query=\(query)" 
        }
    }
    var urlString: String {
        return url.absoluteString
    }
}
