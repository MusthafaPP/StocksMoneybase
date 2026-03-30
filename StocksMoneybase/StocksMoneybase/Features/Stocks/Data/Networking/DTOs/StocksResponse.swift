import Foundation

// MARK: - Top-level response
struct StocksResponse: Decodable {
    let marketSummary: StocksSummary

    enum CodingKeys: String, CodingKey {
        case marketSummary = "marketSummaryAndSparkResponse"
    }
}

// MARK: - MarketSummary container
struct StocksSummary: Decodable {
    let result: [StockItem]
    let error: String?
}

// MARK: - Each market summary item
struct StockItem: Decodable, Identifiable {
    let fullExchangeName: String
    let symbol: String
    let gmtOffSetMilliseconds: Int?
    let language: String?
    let regularMarketTime: RegularMarket?
    let quoteType: String?
    let spark: Spark?
    let tradeable: Bool?
    let regularMarketPreviousClose: RegularMarket?
    let regularMarketChangePercent: MarketChangePercent?
    let exchangeTimezoneName: String?
    let cryptoTradeable: Bool?
    let exchangeDataDelayedBy: Int?
    let firstTradeDateMilliseconds: Int?
    let exchangeTimezoneShortName: String?
    let hasPrePostMarketData: Bool?
    let customPriceAlertConfidence: String?
    let regularMarketPrice: RegularMarket?
    let marketState: String?
    let market: String?
    let priceHint: Int?
    let exchange: String?
    let sourceInterval: Int?
    let shortName: String?
    let region: String?
    let triggerable: Bool?

    var id: String { symbol }

    enum CodingKeys: String, CodingKey {
        case fullExchangeName, symbol, gmtOffSetMilliseconds, language
        case regularMarketTime, quoteType, spark, tradeable
        case regularMarketPreviousClose, regularMarketChangePercent
        case exchangeTimezoneName, cryptoTradeable, exchangeDataDelayedBy
        case firstTradeDateMilliseconds, exchangeTimezoneShortName
        case hasPrePostMarketData, customPriceAlertConfidence
        case regularMarketPrice, marketState, market
        case priceHint, exchange, sourceInterval
        case shortName, region, triggerable
    }
}

// MARK: - RegularMarket price object (SAFE)
struct RegularMarket: Decodable {
    let raw: Double?
    let fmt: String?
}

// MARK: - Flexible Change Percent Decoder
struct MarketChangePercent: Decodable {
    let raw: Double?
    let fmt: String?

    init(raw: Double?, fmt: String?) {
        self.raw = raw
        self.fmt = fmt
    }

    init(from decoder: Decoder) throws {
        // nil case
        if let single = try? decoder.singleValueContainer(),
           single.decodeNil() {
            self.raw = nil
            self.fmt = nil
            return
        }

        // object case { raw, fmt }
        if let container = try? decoder.container(keyedBy: CodingKeys.self) {
            if container.contains(.raw) || container.contains(.fmt) {
                self.raw = try? container.decode(Double.self, forKey: .raw)
                self.fmt = try? container.decode(String.self, forKey: .fmt)
                return
            }
        }

        // single value fallback
        let single = try decoder.singleValueContainer()

        // number
        if let value = try? single.decode(Double.self) {
            self.raw = value
            self.fmt = nil
            return
        }

        // string (e.g. "1.23%")
        if let value = try? single.decode(String.self) {
            self.fmt = value
            let cleaned = value.replacingOccurrences(of: "%", with: "")
            self.raw = Double(cleaned)
            return
        }

        self.raw = nil
        self.fmt = nil
    }

    private enum CodingKeys: String, CodingKey {
        case raw
        case fmt
    }
}

// MARK: - Spark chart data (SAFE)
struct Spark: Decodable {
    let timestamp: [Int]?
    let end: Int?
    let symbol: String?
    let close: [Double]?
    let dataGranularity: Int?
    let previousClose: Double?
    let chartPreviousClose: Double?
    let start: Int?
}
