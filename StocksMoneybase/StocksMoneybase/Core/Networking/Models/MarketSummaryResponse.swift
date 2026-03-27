//
//  MarketSummaryResponse.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 27/03/2026.
//

import Foundation

// MARK: - Top-level response
struct MarketSummaryResponse: Decodable {
    let marketSummary: MarketSummary
    
    enum CodingKeys: String, CodingKey {
        case marketSummary = "marketSummaryAndSparkResponse"
    }
}

// MARK: - MarketSummary container
struct MarketSummary: Decodable {
    let result: [MarketSummaryItem]
    let error: String?
}

// MARK: - Each market summary item
struct MarketSummaryItem: Decodable, Identifiable {
    let fullExchangeName, symbol: String
    let gmtOffSetMilliseconds: Int?
    let language: String?
    let regularMarketTime: RegularMarket?
    let quoteType: String?
    let spark: Spark?
    let tradeable: Bool?
    let regularMarketPreviousClose: RegularMarket?
    let exchangeTimezoneName: String?
    let cryptoTradeable: Bool?
    let exchangeDataDelayedBy, firstTradeDateMilliseconds: Int?
    let exchangeTimezoneShortName: String?
    let hasPrePostMarketData: Bool?
    let customPriceAlertConfidence: String?
    let regularMarketPrice: RegularMarket?
    let marketState, market: String?
    let priceHint: Int?
    let exchange: String?
    let sourceInterval: Int?
    let shortName, region: String?
    let triggerable: Bool?
    
    var id: String { symbol }
}

// MARK: - RegularMarket price object
struct RegularMarket: Decodable {
    let raw: Double
    let fmt: String
}

// MARK: - Spark chart data
struct Spark: Decodable {
    let timestamp: [Int]
    let end: Int
    let symbol: String
    let close: [Double]
    let dataGranularity: Int
    let previousClose: Double
    let chartPreviousClose: Double
    let start: Int
}
