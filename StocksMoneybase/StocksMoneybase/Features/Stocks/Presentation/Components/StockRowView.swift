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
            // MARK: - Left Section: Name + Symbol
            leftSection
            
            Spacer()
            
            // MARK: - Right Section: Price + Change
            rightSection
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color(uiColor: .systemBackground))
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.02), radius: 1, x: 0, y: 1)
    }
}

// MARK: - Private Helpers
private extension StockRowView {
    
    // MARK: - Left Section
    var leftSection: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(stock.name)
                .font(AppFonts.headline)
                .lineLimit(1)
            
            Text(stock.symbol.uppercased())
                .font(AppFonts.caption)
                .foregroundColor(AppColors.mutedText)
        }
    }
    
    // MARK: - Right Section (Price + Change)
    var rightSection: some View {
        VStack(alignment: .trailing, spacing: 4) {
            // Current Price
            Text(stock.priceText ?? "—")
                .font(AppFonts.headline.monospacedDigit())
            
            // Change Section with % and absolute change in brackets
            if let changePercentText = stock.changePercentText,
               let changePercentValue = stock.changePercentValue {
                changeView(
                    text: changePercentText,
                    percentValue: changePercentValue,
                    changeValue: stock.changeValue
                )
            } else {
                Text("—")
                    .font(AppFonts.caption)
                    .foregroundColor(AppColors.secondaryText)
            }
        }
    }
    
    // MARK: - Change View (% Change + Absolute Change in Brackets)
    func changeView(text: String, percentValue: Double, changeValue: Double?) -> some View {
        HStack(spacing: 6) {
            Image(systemName: arrowName(for: percentValue))
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(changeColor(for: percentValue))
            
            Text(text)  // e.g. "-0.69%"
                .font(AppFonts.caption.monospacedDigit())
                .foregroundColor(changeColor(for: percentValue))
            
            // Absolute change in brackets
            if let changeValue = changeValue {
                Text("(\(formatChangeValue(changeValue)))")
                    .font(AppFonts.caption.monospacedDigit())
                    .foregroundColor(changeColor(for: percentValue))
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 3)
        .background(changeColor(for: percentValue).opacity(0.12))
        .cornerRadius(6)
    }
    
    // MARK: - Helpers
    func arrowName(for value: Double) -> String {
        if value > 0 { return "arrow.up" }
        if value < 0 { return "arrow.down" }
        return "minus"
    }
    
    func changeColor(for value: Double) -> Color {
        if value > 0 { return AppColors.positive }
        if value < 0 { return AppColors.negative }
        return AppColors.secondaryText
    }
    
    private func formatChangeValue(_ value: Double) -> String {
        let sign = value >= 0 ? "+" : ""
        return "\(sign)\(String(format: "%.2f", value))"
    }
}


//import SwiftUI
//
//struct StockRowView: View {
//    let stock: Stock
//    
//    var body: some View {
//        HStack {
//            // MARK: - Left Section: Name + Symbol
//            leftSection
//            
//            Spacer()
//            
//            // MARK: - Right Section: Price + Change
//            rightSection
//        }
//        .padding(.vertical, 8)
//        .padding(.horizontal, 12)
//        .background(Color(uiColor: .systemBackground))
//        .cornerRadius(8)
//        .shadow(color: Color.black.opacity(0.02), radius: 1, x: 0, y: 1)
//    }
//}
//
//// MARK: - Private Helpers
//private extension StockRowView {
//    
//    // MARK: - Left Section
//    var leftSection: some View {
//        VStack(alignment: .leading, spacing: 2) {
//            Text(stock.name)
//                .font(AppFonts.headline)
//                .lineLimit(1)
//            
//            Text(stock.symbol.uppercased())
//                .font(AppFonts.caption)
//                .foregroundColor(AppColors.mutedText)
//        }
//    }
//    
//    // MARK: - Right Section (Current Price + Change)
//    var rightSection: some View {
//        VStack(alignment: .trailing, spacing: 4) {
//            // Current Price
//            Text(stock.priceText ?? "—")
//                .font(AppFonts.headline.monospacedDigit())
//            
//            // Change Section (% Change with arrow)
//            if let changePercentText = stock.changePercentText,
//               let changePercentValue = stock.changePercentValue {
//                changeView(text: changePercentText, value: changePercentValue)
//            } else {
//                Text("—")
//                    .font(AppFonts.caption)
//                    .foregroundColor(AppColors.secondaryText)
//            }
//        }
//    }
//    
//    // MARK: - Change View with Arrow, Text & Background
//    func changeView(text: String, value: Double) -> some View {
//        HStack(spacing: 6) {
//            Image(systemName: arrowName(for: value))
//                .font(.system(size: 14, weight: .semibold))
//                .foregroundColor(changeColor(for: value))
//            
//            Text(text)
//                .font(AppFonts.caption.monospacedDigit())
//                .foregroundColor(changeColor(for: value))
//        }
//        .padding(.horizontal, 8)
//        .padding(.vertical, 3)
//        .background(changeColor(for: value).opacity(0.12))
//        .cornerRadius(6)
//    }
//    
//    // MARK: - Helpers
//    func arrowName(for value: Double) -> String {
//        if value > 0 { return "arrow.up" }
//        if value < 0 { return "arrow.down" }
//        return "minus"
//    }
//    
//    func changeColor(for value: Double) -> Color {
//        if value > 0 { return AppColors.positive }
//        if value < 0 { return AppColors.negative }
//        return AppColors.secondaryText
//    }
//    
//    // MARK: - Change View (Updated)
//    func changeView(text: String, percentValue: Double, changeValue: Double?) -> some View {
//        HStack(spacing: 6) {
//            Image(systemName: arrowName(for: percentValue))
//                .font(.system(size: 14, weight: .semibold))
//                .foregroundColor(changeColor(for: percentValue))
//            
//            Text(text)  // e.g. "-0.69%"
//                .font(AppFonts.caption.monospacedDigit())
//                .foregroundColor(changeColor(for: percentValue))
//            
//            // New: Show absolute change in brackets
//            if let changeValue = changeValue {
//                Text("(\(formatChangeValue(changeValue)))")
//                    .font(AppFonts.caption.monospacedDigit())
//                    .foregroundColor(changeColor(for: percentValue))
//            }
//        }
//        .padding(.horizontal, 8)
//        .padding(.vertical, 3)
//        .background(changeColor(for: percentValue).opacity(0.12))
//        .cornerRadius(6)
//    }
//
//    private func formatChangeValue(_ value: Double) -> String {
//        let sign = value >= 0 ? "+" : ""
//        return "\(sign)\(String(format: "%.2f", value))"
//    }
//}
//
//
