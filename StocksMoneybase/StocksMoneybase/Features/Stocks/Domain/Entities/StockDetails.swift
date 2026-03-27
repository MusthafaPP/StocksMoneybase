////
////  Stock 2.swift
////  StocksMoneybase
////
////  Created by Muhammed Musthafa on 27/03/2026.
////
//
//import Foundation
// MARK: - StockDetails Domain Model

struct StockDetails {
    struct Identity {
        let symbol: String
        let shortName: String?
        let longName: String?
        let instrumentType: String
    }
    
    struct Pricing {
        let currency: String
        let currentPrice: Double
        let previousClose: Double
        let chartPreviousClose: Double
        let priceHint: Int
        let scale: Int
        let open: [Double?]
        let close: [Double?]
        let high: [Double?]
        let low: [Double?]
        let volume: [Double?]
    }
    
    struct Range {
        let dayHigh: Double
        let dayLow: Double
        let fiftyTwoWeekHigh: Double
        let fiftyTwoWeekLow: Double
    }
    
    struct Volume {
        let regularMarketVolume: Int
    }
    
    struct Market {
        let exchangeName: String
        let fullExchangeName: String
        let timezone: String
        let exchangeTimezoneName: String
        let gmtOffset: Int
    }
    
    struct Period {
        let timezone: String
        let start: Int
        let end: Int
        let gmtOffset: Int
    }
    
    struct TradingPeriod {
        let pre: Period
        let regular: Period
        let post: Period
    }
    
    struct TradingPeriods {
        let pre: [[Period]]
        let regular: [[Period]]
        let post: [[Period]]
    }
    
    struct Trading {
        let firstTradeDate: Int
        let regularMarketTime: Int
        let hasPrePostMarketData: Bool
        let currentTradingPeriod: TradingPeriod?
        let tradingPeriods: TradingPeriods
    }
    
    struct Metadata {
        let dataGranularity: String
        let range: String
        let validRanges: [String]
    }
    
    let identity: Identity
    let pricing: Pricing
    let range: Range
    let volume: Volume
    let market: Market
    let trading: Trading
    let metadata: Metadata
    let timestamps: [Int]
}
