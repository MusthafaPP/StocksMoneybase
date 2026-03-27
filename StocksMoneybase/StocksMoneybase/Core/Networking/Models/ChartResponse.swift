//
//  ChartResponse.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 27/03/2026.
//


import Foundation


struct ChartResponse: Decodable {
    let chart: ChartData
}

struct ChartData: Decodable {
    let result: [ChartResult]
    let error: String?
}

struct ChartResult: Decodable {
    let meta: ChartMeta
    let timestamp: [Int]?
    let indicators: Indicators
}

struct ChartMeta: Decodable {
    let currency: String
    let symbol: String
    let exchangeName: String
    let fullExchangeName: String
    let instrumentType: String
    let firstTradeDate: Int
    let regularMarketTime: Int
    let hasPrePostMarketData: Bool
    let gmtoffset: Int
    let timezone: String
    let exchangeTimezoneName: String
    let regularMarketPrice: Double
    let fiftyTwoWeekHigh: Double
    let fiftyTwoWeekLow: Double
    let regularMarketDayHigh: Double
    let regularMarketDayLow: Double
    let regularMarketVolume: Int
    let longName: String
    let shortName: String
    let chartPreviousClose: Double
    let previousClose: Double
    let scale: Int
    let priceHint: Int
    let currentTradingPeriod: TradingPeriodData
    let tradingPeriods: TradingPeriods
    let dataGranularity: String
    let range: String
    let validRanges: [String]
}

struct TradingPeriodData: Decodable {
    let pre: TradingPeriod
    let regular: TradingPeriod
    let post: TradingPeriod
}

struct TradingPeriod: Decodable {
    let timezone: String
    let end: Int
    let start: Int
    let gmtoffset: Int
}

struct TradingPeriods: Decodable {
    let pre: [[TradingPeriod]]
    let regular: [[TradingPeriod]]
    let post: [[TradingPeriod]]
}

struct Indicators: Decodable {
    let quote: [Quote]
}

struct Quote: Decodable {
    let open: [Double?]?
    let close: [Double?]?
    let high: [Double?]?
    let low: [Double?]?
    let volume: [Double?]?
}
