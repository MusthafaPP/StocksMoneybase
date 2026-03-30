import Foundation
import Testing
@testable import StocksMoneybase

@Suite("Request Builder")
struct URLRequestBuilderTests {

    @Test("Builds URLRequest with method, headers, and query")
    func buildRequestSuccess() throws {
        let builder = URLRequestBuilder()
        let endpoint = StockDetailsEndpoint(symbol: "TSLA")

        let request = try builder.buildRequest(from: endpoint)

        #expect(request.httpMethod == "GET")
        #expect(request.url?.absoluteString.contains("symbol=TSLA") == true)
        #expect(request.url?.absoluteString.contains("interval=5m") == true)
        #expect(request.value(forHTTPHeaderField: "x-rapidapi-host") == "yh-finance.p.rapidapi.com")
    }
}


