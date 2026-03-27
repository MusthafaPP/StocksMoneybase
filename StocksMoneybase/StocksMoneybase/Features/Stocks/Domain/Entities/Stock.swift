//
//  Stock.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 26/03/2026.
//

import Foundation

/// Domain entity used by the UI.
struct Stock: Identifiable, Hashable {
    let symbol: String
    let name: String
    let shortName: String?

    let priceText: String?
    let previousCloseText: String?

    let changePercentValue: Double?
    let changePercentText: String?

    // Detail screen fields
    let fullExchangeName: String
    let region: String?
    let marketState: String?
    let quoteType: String?
    let tradeable: Bool?
    let priceHint: Int?
    let sourceInterval: Int?

    var id: String { symbol }
}

