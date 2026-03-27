//
//  StockListViewModel.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 26/03/2026.
//

import SwiftUI
import Combine

@MainActor
final class MarketSummaryListViewModel: ObservableObject {
    
    @Published var stocks: [Stock] = []
    @Published var searchText = ""
    @Published var isLoading = false
    
    private let useCase: StocksUseCase
    
    init(useCase: StocksUseCase) {
        self.useCase = useCase
    }

    var filteredStocks: [Stock] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return stocks }

        return stocks.filter { stock in
            stock.name.localizedCaseInsensitiveContains(query)
        }
    }
    
    func loadMarketSummaries() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            stocks = try await useCase.execute()
        } catch {
            print("Error:", error)
        }
    }
}
