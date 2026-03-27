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
        NavigationStack {
            List(viewModel.filteredStocks) { stock in
                NavigationLink {
                    MarketSummaryDIContainer.makeMarketSummaryDetailView(stock: stock)
                } label: {
                    StockRowView(stock: stock)
                }
            }
            .navigationTitle("Stocks")
            .searchable(
                text: $viewModel.searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search by stock name"
            )
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
