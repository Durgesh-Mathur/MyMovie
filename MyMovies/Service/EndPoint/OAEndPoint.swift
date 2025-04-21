

import Foundation

enum OAHost: String {
    case base

    var url: String {
        return switch self {
        case .base : "https://api.themoviedb.org"
        }
    }
}
enum OAEndpoint {
    case fetchMovies(apiKey: String)
    case fetchMovieDetails(id: Int, apiKey: String)
    case searchMovies(query: String, apiKey: String)
    var method: String {
        return switch self {
        case  .fetchMovies: "GET"
        case  .fetchMovieDetails: "GET"
        case .searchMovies: "GET"
        default: "POST"
        }
    }
    
    var retryCount : Int {
        return switch self {
        default : 1
        }
    }
 
}

