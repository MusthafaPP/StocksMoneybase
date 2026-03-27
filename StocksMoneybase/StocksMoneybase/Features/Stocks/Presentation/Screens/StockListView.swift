//
//  StockListView.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 26/03/2026.
//

import SwiftUI

struct MarketSummaryListView: View {
    
    @StateObject var viewModel: MarketSummaryListViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.marketSummaries) { marketSummary in
                MarketSummaryRowView(marketSummary: marketSummary)
            }
            .navigationTitle("Market Summary")
            .overlay {
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .task {
                await viewModel.loadMarketSummaries()
            }
            .refreshable {
                await viewModel.loadMarketSummaries()
            }
        }
    }
}
