import Foundation

enum SearchEndpoint: Endpoint {
    case search(searchTerm: String, limit: String)

    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }

    var baseURL: String {
        switch self {
        default:
            return APIKeys.keys.apiUrl
        }
    }

    var path: String{
        switch self {
        case .search:
            return "/v1/search/link-items"
        }
    }

    var parameters: [URLQueryItem] {
        switch self {
        case .search(let searchTerm, let limit):
            return [
                URLQueryItem(name: "limit", value: limit),
                URLQueryItem(name: "q", value: searchTerm),
            ]
        }
    }

    var method: String {
        switch self {
        case .search:
            return "GET"
        }
    }
}
