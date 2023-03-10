import Foundation

struct APIKeys: Decodable {
    let apiKeyId: String
    let apiKeySecret: String
    let apiUrl: String

    enum CodingKeys: String, CodingKey {
        case apiKeyId = "api_key_id"
        case apiKeySecret = "api_key_secret"
        case apiUrl = "api_url"
    }
    static let keys: APIKeys = {
        guard let url = Bundle.main.url(forResource: "API", withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let apiKeys = try? PropertyListDecoder().decode(APIKeys.self, from: data)
        else {
            fatalError("Failed to load APIKeys from plist.")
        }
        return apiKeys
    }()
}
