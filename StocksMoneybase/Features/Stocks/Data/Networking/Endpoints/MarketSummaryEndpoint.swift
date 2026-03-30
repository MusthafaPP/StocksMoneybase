import Foundation

struct MarketSummaryEndpoint: APIEndpoint {
    typealias Response = MarketSummaryResponse

    var baseURL: String { NetworkConfigProvider.shared.baseURL }
    var path: String { "/market/v2/get-summary" }
    var method: HTTPMethod { .get }
    var queryItems: [URLQueryItem]? { [URLQueryItem(name: "region", value: "US")] }

    var headers: [String: String]? {
        var headers: [String: String] = [
            "Content-Type": "application/json",
            "x-rapidapi-host": NetworkConfigProvider.shared.rapidAPIHost
        ]
        if let key = NetworkConfigProvider.shared.rapidAPIKey {
            headers["x-rapidapi-key"] = key
        }
        return headers
    }
}

