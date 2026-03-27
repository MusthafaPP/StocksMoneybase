//
//  StockRowView.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 26/03/2026.
//

import SwiftUI

struct MarketSummaryRowView: View {
    
    let marketSummary: MarketSummaryItem
    
    var body: some View {
        HStack {
            
            VStack(alignment: .leading) {
                Text(marketSummary.shortName ?? marketSummary.fullExchangeName)
                    .font(.headline)
                
                Text(marketSummary.symbol)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(marketSummary.regularMarketPrice?.fmt ?? "-")
                    .font(.headline)
            }
        }
        .padding(.vertical, 6)
    }
}
