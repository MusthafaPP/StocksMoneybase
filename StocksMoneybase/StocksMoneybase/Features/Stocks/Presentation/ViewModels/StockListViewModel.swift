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
    
    @Published var marketSummaries: [MarketSummaryItem] = []
    @Published var searchText = ""
    @Published var isLoading = false
    
    private let useCase: GetMarketSummaryUseCase
    
    init(useCase: GetMarketSummaryUseCase) {
        self.useCase = useCase
    }

    var filteredMarketSummaries: [MarketSummaryItem] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return marketSummaries }

        return marketSummaries.filter { item in
            let displayName = item.shortName ?? item.fullExchangeName
            return displayName.localizedCaseInsensitiveContains(query)
        }
    }
    
    func loadMarketSummaries() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            marketSummaries = try await useCase.execute()
        } catch {
            print("Error:", error)
        }
    }
}
