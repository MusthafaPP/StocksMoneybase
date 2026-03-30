import Foundation

struct StockDetailsEndpoint: APIEndpoint {
    typealias Response = ChartResponse

    let symbol: String

    var baseURL: String { NetworkConfigProvider.shared.baseURL }
    var path: String { "/stock/v2/get-chart" }
    var method: HTTPMethod { .get }
    var queryItems: [URLQueryItem]? {
        [
            URLQueryItem(name: "interval", value: "5m"),
            URLQueryItem(name: "symbol", value: symbol),
            URLQueryItem(name: "range", value: "1d"),
            URLQueryItem(name: "region", value: "US")
        ]
    }

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

