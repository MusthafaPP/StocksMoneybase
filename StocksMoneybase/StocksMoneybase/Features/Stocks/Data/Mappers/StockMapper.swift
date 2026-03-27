//
//  StockMapper.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 26/03/2026.
//

import Foundation

struct StockMapper {
    
    static func mapToStock(_ item: StockItem) -> Stock {
        let name = item.shortName ?? item.fullExchangeName
        
        let currentPrice = item.regularMarketPrice?.raw
        let previousClose = item.regularMarketPreviousClose?.raw
        
        let changeValue = calculateChange(current: currentPrice, previous: previousClose)
        let changePercentValue = calculateChangePercent(current: currentPrice, previous: previousClose)
        
        return Stock(
            symbol: item.symbol,
            name: name,
            shortName: item.shortName,
            
            priceText: item.regularMarketPrice?.fmt,
            previousCloseText: item.regularMarketPreviousClose?.fmt,
            
            changeValue: changeValue,
            changeText: formatChangeText(changeValue),
            
            changePercentValue: changePercentValue,
            changePercentText: formatChangePercentText(changePercentValue),
            
            // Detail fields
            fullExchangeName: item.fullExchangeName,
            region: item.region,
            marketState: item.marketState,
            quoteType: item.quoteType,
            tradeable: item.tradeable,
            priceHint: item.priceHint,
            sourceInterval: item.sourceInterval
        )
    }
    
    // MARK: - Helpers
    
    private static func calculateChange(current: Double?, previous: Double?) -> Double? {
        guard let current = current, let previous = previous else { return nil }
        return current - previous
    }
    
    private static func calculateChangePercent(current: Double?, previous: Double?) -> Double? {
        guard let current = current,
              let previous = previous,
              previous != 0 else {
            return nil
        }
        return ((current - previous) / previous) * 100
    }
    
    private static func formatChangeText(_ value: Double?) -> String? {
        guard let value = value else { return nil }
        return String(format: "%.2f", value)
    }
    
    private static func formatChangePercentText(_ value: Double?) -> String? {
        guard let value = value else { return nil }
        
        let sign = value >= 0 ? "+" : ""
        let formatted = String(format: "%.2f", value)
        return "\(sign)\(formatted)%"
    }
}
