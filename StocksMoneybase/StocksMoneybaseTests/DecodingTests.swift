import Foundation
import Testing
@testable import StocksMoneybase

@Suite("Model Decoding")
struct DecodingTests {

    @Test("Decodes MarketSummaryResponse JSON payload")
    func decodeMarketSummaryResponse() throws {
        let json = """
        {
          "marketSummaryAndSparkResponse": {
            "result": [
              {
                "fullExchangeName": "NasdaqGS",
                "symbol": "^IXIC",
                "regularMarketPrice": { "raw": 17000.25, "fmt": "17,000.25" },
                "regularMarketChangePercent": { "raw": 1.23, "fmt": "1.23%" },
                "shortName": "NASDAQ",
                "spark": {
                  "timestamp": [1,2],
                  "end": 2,
                  "symbol": "^IXIC",
                  "close": [17000.0,17000.25],
                  "dataGranularity": 5,
                  "previousClose": 16900.0,
                  "chartPreviousClose": 16900.0,
                  "start": 1
                }
              }
            ],
            "error": null
          }
        }
        """

        let data = try #require(json.data(using: .utf8))
        let decoded = try JSONDecoder().decode(StocksResponse.self, from: data)

        #expect(decoded.marketSummary.error == nil)
        #expect(decoded.marketSummary.result.count == 1)
        #expect(decoded.marketSummary.result[0].symbol == "^IXIC")
        #expect(decoded.marketSummary.result[0].regularMarketPrice?.fmt == "17,000.25")
        #expect(decoded.marketSummary.result[0].regularMarketChangePercent?.raw == 1.23)
    }

    @Test("Decodes regularMarketChangePercent numeric fallback")
    func decodeRegularMarketChangePercentNumeric() throws {
        let json = """
        {
          "marketSummaryAndSparkResponse": {
            "result": [
              {
                "fullExchangeName": "NasdaqGS",
                "symbol": "^IXIC",
                "regularMarketPrice": { "raw": 17000.25, "fmt": "17,000.25" },
                "regularMarketChangePercent": 4.5,
                "shortName": "NASDAQ",
                "spark": {
                  "timestamp": [1,2],
                  "end": 2,
                  "symbol": "^IXIC",
                  "close": [17000.0,17000.25],
                  "dataGranularity": 5,
                  "previousClose": 16900.0,
                  "chartPreviousClose": 16900.0,
                  "start": 1
                }
              }
            ],
            "error": null
          }
        }
        """

        let data = try #require(json.data(using: .utf8))
        let decoded = try JSONDecoder().decode(StocksResponse.self, from: data)

        #expect(decoded.marketSummary.result[0].regularMarketChangePercent?.raw == 4.5)
    }

    @Test("Decodes ChartResponse JSON payload")
    func decodeChartResponse() throws {
        let json = """
        {
          "chart": {
            "result": [
              {
                "meta": {
                  "currency": "USD",
                  "symbol": "AAPL",
                  "exchangeName": "NMS",
                  "fullExchangeName": "NasdaqGS",
                  "instrumentType": "EQUITY",
                  "firstTradeDate": 345479400,
                  "regularMarketTime": 1700000000,
                  "hasPrePostMarketData": true,
                  "gmtoffset": -14400,
                  "timezone": "EDT",
                  "exchangeTimezoneName": "America/New_York",
                  "regularMarketPrice": 180.5,
                  "fiftyTwoWeekHigh": 200.0,
                  "fiftyTwoWeekLow": 120.0,
                  "regularMarketDayHigh": 181.0,
                  "regularMarketDayLow": 179.0,
                  "regularMarketVolume": 1000000,
                  "longName": "Apple Inc.",
                  "shortName": "Apple",
                  "chartPreviousClose": 179.0,
                  "previousClose": 179.0,
                  "scale": 3,
                  "priceHint": 2,
                  "currentTradingPeriod": {
                    "pre": { "timezone": "EDT", "end": 1, "start": 1, "gmtoffset": -14400 },
                    "regular": { "timezone": "EDT", "end": 1, "start": 1, "gmtoffset": -14400 },
                    "post": { "timezone": "EDT", "end": 1, "start": 1, "gmtoffset": -14400 }
                  },
                  "tradingPeriods": {
                    "pre": [[{ "timezone": "EDT", "end": 1, "start": 1, "gmtoffset": -14400 }]],
                    "regular": [[{ "timezone": "EDT", "end": 1, "start": 1, "gmtoffset": -14400 }]],
                    "post": [[{ "timezone": "EDT", "end": 1, "start": 1, "gmtoffset": -14400 }]]
                  },
                  "dataGranularity": "5m",
                  "range": "1d",
                  "validRanges": ["1d","5d"]
                },
                "timestamp": [1,2,3],
                "indicators": {
                  "quote": [
                    {
                      "open": [1.0,2.0],
                      "close": [1.1,2.1],
                      "high": [1.2,2.2],
                      "low": [0.9,1.9],
                      "volume": [100.0,200.0]
                    }
                  ]
                }
              }
            ],
            "error": null
          }
        }
        """

        let data = try #require(json.data(using: .utf8))
        let decoded = try JSONDecoder().decode(ChartResponse.self, from: data)

        #expect(decoded.chart.error == nil)
        #expect(decoded.chart.result.count == 1)
        #expect(decoded.chart.result[0].meta.symbol == "AAPL")
        #expect(decoded.chart.result[0].timestamp?.count == 3)
    }
}
