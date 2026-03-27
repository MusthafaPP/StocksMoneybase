import Foundation
import Testing
@testable import StocksMoneybase

@Suite("Endpoint Configuration")
struct EndpointConfigurationTests {

    @Test("MarketSummaryEndpoint has expected defaults")
    func marketSummaryEndpointDefaults() {
        let endpoint = StocksEndpoint()
        #expect(endpoint.baseURL == "https://yh-finance.p.rapidapi.com")
        #expect(endpoint.path == "/market/v2/get-summary")
        #expect(endpoint.method == .get)
        #expect(endpoint.queryItems?.first(where: { $0.name == "region" })?.value == "US")
        #expect(endpoint.headers?["Content-Type"] == "application/json")
        #expect(endpoint.headers?["x-rapidapi-host"] == "yh-finance.p.rapidapi.com")
    }

    @Test("ChartEndpoint uses symbol and expected query values")
    func chartEndpointUsesSymbol() {
        let endpoint = StockDetailsEndpoint(symbol: "AAPL")
        #expect(endpoint.path == "/stock/v2/get-chart")
        #expect(endpoint.method == .get)
        #expect(endpoint.queryItems?.first(where: { $0.name == "symbol" })?.value == "AAPL")
        #expect(endpoint.queryItems?.first(where: { $0.name == "interval" })?.value == "5m")
        #expect(endpoint.queryItems?.first(where: { $0.name == "range" })?.value == "1d")
        #expect(endpoint.queryItems?.first(where: { $0.name == "region" })?.value == "US")
    }
}
