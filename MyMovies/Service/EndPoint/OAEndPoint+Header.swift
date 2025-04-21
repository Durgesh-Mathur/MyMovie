
import Foundation
extension OAEndpoint {
    var headers: [String: String] {
        return switch self {
        default :
            [:]
//            ["Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwYTBkZTVhM2YyNDg3M2U4Yjc2MGRiMzZmNjRiNTY0ZCIsIm5iZiI6MTc0NTIxOTcyOC45MjMsInN1YiI6IjY4MDVmMDkwYjY1OTgyMjgxMmVlNDQ1MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.0iYhmyimudDomGZBh4XdAe9ZeqAWKbj8N08etirpP-E",
//             "accept": "application/json"]
        }
    }
}
