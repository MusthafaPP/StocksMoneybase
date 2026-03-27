//
//  StockMapper.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 26/03/2026.
//

import Foundation

/// Maps API DTOs (`MarketSummaryItem`) into domain entities (`Stock`).
struct StockMapper {
    static func mapToStock(_ item: StockItem) -> Stock {
        let name = item.shortName ?? item.fullExchangeName

        let priceText = item.regularMarketPrice?.fmt
        let previousCloseText = item.regularMarketPreviousClose?.fmt

        let changePercentValue = item.regularMarketChangePercent?.raw
        let changePercentText = normalizedChangePercentText(
            raw: item.regularMarketChangePercent?.raw,
            fmt: item.regularMarketChangePercent?.fmt
        )

        return Stock(
            symbol: item.symbol,
            name: name,
            shortName: item.shortName,
            priceText: priceText,
            previousCloseText: previousCloseText,
            changePercentValue: changePercentValue,
            changePercentText: changePercentText,
            fullExchangeName: item.fullExchangeName,
            region: item.region,
            marketState: item.marketState,
            quoteType: item.quoteType,
            tradeable: item.tradeable,
            priceHint: item.priceHint,
            sourceInterval: item.sourceInterval
        )
    }

    private static func normalizedChangePercentText(raw: Double?, fmt: String?) -> String? {
        // Prefer `fmt` when available.
        if let fmt, !fmt.isEmpty {
            if fmt.contains("%") {
                return fmt
            }

            if let raw {
                let sign = raw > 0 ? "+" : ""
                return "\(sign)\(fmt)%"
            }

            return "\(fmt)%"
        }

        // Otherwise, try building from raw.
        guard let raw else { return nil }
        let sign = raw > 0 ? "+" : ""
        return "\(sign)\(raw)%"
    }
}
