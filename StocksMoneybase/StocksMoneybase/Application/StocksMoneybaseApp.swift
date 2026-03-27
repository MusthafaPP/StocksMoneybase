//
//  StocksMoneybaseApp.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 26/03/2026.
//

import SwiftUI
import SwiftData

@main
struct StocksMoneybaseApp: App {
    var body: some Scene {
        WindowGroup {
            MarketSummaryDIContainer.makeMarketSummaryListView()
        }
    }
}
