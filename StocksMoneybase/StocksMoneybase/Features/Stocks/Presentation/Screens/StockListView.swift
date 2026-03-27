//
//  StockListView.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 26/03/2026.
//

import SwiftUI

struct StockListView: View {
    
    @StateObject var viewModel: MarketSummaryListViewModel
    
    var body: some View {
        NavigationStack {
            List(viewModel.filteredStocks) { stock in
                NavigationLink {
                    MarketSummaryDIContainer.makeMarketSummaryDetailView(stock: stock)
                } label: {
                    StockRowView(stock: stock)
                }
                .buttonStyle(PlainButtonStyle())        // Removes default selection highlight
                .listRowBackground(Color.clear)         // Removes list row background
            }
            .listStyle(.plain)                          // Clean list style
            .navigationTitle("Market Summary")
            .searchable(
                text: $viewModel.searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search by stock name"
            )
            .toolbar {
                Menu {
                    ForEach(MarketSummaryListViewModel.SortOption.allCases) { option in
                        Button {
                            viewModel.sortOption = option
                        } label: {
                            HStack {
                                Text(option.rawValue)
                                if viewModel.sortOption == option {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                } label: {
                    Image(systemName: "arrow.up.arrow.down")
                        .imageScale(.medium)
                }
            }
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
