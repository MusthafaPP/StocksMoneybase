//
//  Stock.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 26/03/2026.
//

import Foundation

struct Stock: Identifiable, Hashable {
    let symbol: String
    let name: String
    let shortName: String?
    
    // Price fields
    let priceText: String?           // Current Price (formatted)
    let previousCloseText: String?   // Previous Close (formatted)
    
    // Change fields
    let changeValue: Double?         // Absolute change (e.g. -44.66)
    let changeText: String?          // Formatted absolute change (e.g. "-44.66")
    
    let changePercentValue: Double?  // Percentage change (e.g. -0.69)
    let changePercentText: String?   // Formatted percentage (e.g. "-0.69%")
    
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
