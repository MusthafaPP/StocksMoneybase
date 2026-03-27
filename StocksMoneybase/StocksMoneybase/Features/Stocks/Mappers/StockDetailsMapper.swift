////
////  StockDetailsMapper.swift
////  StocksMoneybase
////
////  Created by Muhammed Musthafa on 27/03/2026.
////
//
//import Foundation
//
////struct StockDetailsMapper {
////
////    static func mapToStock(from meta: ChartMeta) -> StockDetails {
////
////        return StockDetails(
////
////            identity: .init(
////                symbol: meta.symbol,
////                shortName: meta.shortName,
////                longName: meta.longName,
////                instrumentType: meta.instrumentType
////            ),
////
////            pricing: .init(
////                currency: meta.currency,
////                currentPrice: meta.regularMarketPrice,
////                previousClose: meta.previousClose,
////                chartPreviousClose: meta.chartPreviousClose,
////                priceHint: meta.priceHint,
////                scale: meta.scale
////            ),
////
////            range: .init(
////                dayHigh: meta.regularMarketDayHigh,
////                dayLow: meta.regularMarketDayLow,
////                fiftyTwoWeekHigh: meta.fiftyTwoWeekHigh,
////                fiftyTwoWeekLow: meta.fiftyTwoWeekLow
////            ),
////
////            volume: .init(
////                regularMarketVolume: meta.regularMarketVolume
////            ),
////
////            market: .init(
////                exchangeName: meta.exchangeName,
////                fullExchangeName: meta.fullExchangeName,
////                timezone: meta.timezone,
////                exchangeTimezoneName: meta.exchangeTimezoneName,
////                gmtOffset: meta.gmtoffset
////            ),
////
////            trading: .init(
////                firstTradeDate: meta.firstTradeDate,
////                regularMarketTime: meta.regularMarketTime,
////                hasPrePostMarketData: meta.hasPrePostMarketData,
////                currentTradingPeriod: mapTradingPeriod(meta.currentTradingPeriod),
////                tradingPeriods: mapTradingPeriods(meta.tradingPeriods)
////            ),
////
////            metadata: .init(
////                dataGranularity: meta.dataGranularity,
////                range: meta.range,
////                validRanges: meta.validRanges
////            )
////        )
////    }
////}
////
////// MARK: - Private Helpers
////
////private extension StockDetailsMapper {
////
////    static func mapTradingPeriod(_ input: TradingPeriodData) -> StockDetails.TradingPeriod {
////        return .init(
////            pre: mapPeriod(input.pre),
////            regular: mapPeriod(input.regular),
////            post: mapPeriod(input.post)
////        )
////    }
////
////    static func mapTradingPeriods(_ input: TradingPeriods) -> StockDetails.TradingPeriods {
////        return .init(
////            pre: input.pre.map { $0.map(mapPeriod) },
////            regular: input.regular.map { $0.map(mapPeriod) },
////            post: input.post.map { $0.map(mapPeriod) }
////        )
////    }
////
////    static func mapPeriod(_ input: TradingPeriod) -> StockDetails.Period {
////        return .init(
////            timezone: input.timezone,
////            start: input.start,
////            end: input.end,
////            gmtOffset: input.gmtoffset
////        )
////    }
////}
//
//import Foundation
//
//struct StockDetailsMapper {
//
//    static func mapToStock(from chartResult: ChartResult) -> StockDetails {
//
//        let meta = chartResult.meta
//        let quote = chartResult.indicators.quote.first
//
//        return StockDetails(
//
//            // MARK: Identity
//            identity: .init(
//                symbol: meta.symbol,
//                shortName: meta.shortName,
//                longName: meta.longName,
//                instrumentType: meta.instrumentType
//            ),
//
//            // MARK: Pricing
//            pricing: .init(
//                currency: meta.currency,
//                currentPrice: meta.regularMarketPrice,
//                previousClose: meta.previousClose,
//                chartPreviousClose: meta.chartPreviousClose,
//                priceHint: meta.priceHint,
//                scale: meta.scale,
//                open: quote?.open ?? [],
//                close: quote?.close ?? [],
//                high: quote?.high ?? [],
//                low: quote?.low ?? [],
//                volume: quote?.volume ?? []
//            ),
//
//            // MARK: Range
//            range: .init(
//                dayHigh: meta.regularMarketDayHigh,
//                dayLow: meta.regularMarketDayLow,
//                fiftyTwoWeekHigh: meta.fiftyTwoWeekHigh,
//                fiftyTwoWeekLow: meta.fiftyTwoWeekLow
//            ),
//
//            // MARK: Volume
//            volume: .init(
//                regularMarketVolume: meta.regularMarketVolume
//            ),
//
//            // MARK: Market
//            market: .init(
//                exchangeName: meta.exchangeName,
//                fullExchangeName: meta.fullExchangeName,
//                timezone: meta.timezone,
//                exchangeTimezoneName: meta.exchangeTimezoneName,
//                gmtOffset: meta.gmtoffset
//            ),
//
//            // MARK: Trading
//            trading: .init(
//                firstTradeDate: meta.firstTradeDate,
//                regularMarketTime: meta.regularMarketTime,
//                hasPrePostMarketData: meta.hasPrePostMarketData,
//                currentTradingPeriod: mapTradingPeriod(meta.currentTradingPeriod),
//                tradingPeriods: mapTradingPeriods(meta.tradingPeriods)
//            ),
//
//            // MARK: Metadata
//            metadata: .init(
//                dataGranularity: meta.dataGranularity,
//                range: meta.range,
//                validRanges: meta.validRanges
//            )
//        )
//    }
//}
//
//// MARK: - Private Helpers
//
//private extension StockDetailsMapper {
//
//    static func mapTradingPeriod(_ input: TradingPeriodData) -> StockDetails.TradingPeriod {
//        .init(
//            pre: mapPeriod(input.pre),
//            regular: mapPeriod(input.regular),
//            post: mapPeriod(input.post)
//        )
//    }
//
//    static func mapTradingPeriods(_ input: TradingPeriods?) -> StockDetails.TradingPeriods? {
//        guard let input else { return nil }
//
//        func unwrap2D(_ array: [[TradingPeriod]]) -> [[StockDetails.Period]] {
//            array.map { $0.map(mapPeriod) }
//        }
//
//        return .init(
//            pre: unwrap2D(input.pre),
//            regular: unwrap2D(input.regular),
//            post: unwrap2D(input.post)
//        )
//    }
//
//    static func mapPeriod(_ input: TradingPeriod) -> StockDetails.Period {
//        .init(
//            timezone: input.timezone,
//            start: input.start,
//            end: input.end,
//            gmtOffset: input.gmtoffset
//        )
//    }
//}


import Foundation

// MARK: - Mapper

struct StockDetailsMapper {
    
    static func mapToStock(from result: ChartResult) -> StockDetails {
        let meta = result.meta
        let quote = result.indicators.quote.first
        
        return StockDetails(
            identity: .init(
                symbol: meta.symbol,
                shortName: meta.shortName,
                longName: meta.longName,
                instrumentType: meta.instrumentType
            ),
            pricing: .init(
                currency: meta.currency,
                currentPrice: meta.regularMarketPrice,
                previousClose: meta.previousClose,
                chartPreviousClose: meta.chartPreviousClose,
                priceHint: meta.priceHint,
                scale: meta.scale,
                open: quote?.open ?? [],
                close: quote?.close ?? [],
                high: quote?.high ?? [],
                low: quote?.low ?? [],
                volume: quote?.volume ?? []
            ),
            range: .init(
                dayHigh: meta.regularMarketDayHigh,
                dayLow: meta.regularMarketDayLow,
                fiftyTwoWeekHigh: meta.fiftyTwoWeekHigh,
                fiftyTwoWeekLow: meta.fiftyTwoWeekLow
            ),
            volume: .init(
                regularMarketVolume: meta.regularMarketVolume
            ),
            market: .init(
                exchangeName: meta.exchangeName,
                fullExchangeName: meta.fullExchangeName,
                timezone: meta.timezone,
                exchangeTimezoneName: meta.exchangeTimezoneName,
                gmtOffset: meta.gmtoffset
            ),
            trading: .init(
                firstTradeDate: meta.firstTradeDate,
                regularMarketTime: meta.regularMarketTime,
                hasPrePostMarketData: meta.hasPrePostMarketData,
                currentTradingPeriod: meta.currentTradingPeriod != nil ? mapTradingPeriod(meta.currentTradingPeriod!) : nil,
                tradingPeriods: mapTradingPeriods(meta.tradingPeriods)
            ),
            metadata: .init(
                dataGranularity: meta.dataGranularity,
                range: meta.range,
                validRanges: meta.validRanges
            ),
            timestamps: result.timestamp ?? []
        )
    }
}

// MARK: - Private Helpers

private extension StockDetailsMapper {
    
    static func mapTradingPeriod(_ input: TradingPeriodData) -> StockDetails.TradingPeriod {
        return .init(
            pre: mapPeriod(input.pre),
            regular: mapPeriod(input.regular),
            post: mapPeriod(input.post)
        )
    }
    
    static func mapTradingPeriods(_ input: TradingPeriods) -> StockDetails.TradingPeriods {
        return .init(
            pre: input.pre.map { $0.map(mapPeriod) },
            regular: input.regular.map { $0.map(mapPeriod) },
            post: input.post.map { $0.map(mapPeriod) }
        )
    }
    
    static func mapPeriod(_ input: TradingPeriod) -> StockDetails.Period {
        return .init(
            timezone: input.timezone,
            start: input.start,
            end: input.end,
            gmtOffset: input.gmtoffset
        )
    }
}
