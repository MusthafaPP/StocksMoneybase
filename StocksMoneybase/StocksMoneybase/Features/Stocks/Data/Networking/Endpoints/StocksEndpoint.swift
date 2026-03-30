import Foundation

struct StocksEndpoint: APIEndpoint {
    typealias Response = StocksResponse

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
            headers["x-rapidapi-key"] = "501a9ce445msh7a4209530a3dd9dp1dcc1djsn116323932be5"
        }
        return headers
    }
}

