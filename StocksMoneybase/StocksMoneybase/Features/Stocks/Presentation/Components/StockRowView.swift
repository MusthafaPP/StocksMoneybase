//
//  StockRowView.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 26/03/2026.
//

import SwiftUI

struct StockRowView: View {
    let stock: Stock
    
    var body: some View {
        HStack {
            
            VStack(alignment: .leading) {
                Text(stock.name)
                    .font(AppFonts.headline)
                
                Text(stock.symbol)
                    .font(AppFonts.caption)
                    .foregroundColor(AppColors.mutedText)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(stock.priceText ?? "-")
                    .font(AppFonts.headline)

                if let changeText = stock.changePercentText {
                    Text(changeText)
                        .font(AppFonts.caption)
                        .foregroundColor(changeColor)
                }
            }
        }
        .padding(.vertical, 6)
    }

    private var changeColor: Color {
        guard let value = stock.changePercentValue else { return AppColors.secondaryText }
        if value > 0 { return AppColors.positive }
        if value < 0 { return AppColors.negative }
        return AppColors.secondaryText
    }
}
