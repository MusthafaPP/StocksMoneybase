//
//  StockListViewModel.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 26/03/2026.
//



import SwiftUI
import Combine

@MainActor
final class StockListViewModel: ObservableObject {
    
    @Published var stocks: [Stock] = []
    @Published var searchText = ""
    @Published var isLoading = false
    @Published var sortOption: SortOption = .none
    
    private let useCase: StocksUseCase
    
    init(useCase: StocksUseCase) {
        self.useCase = useCase
    }
    
    enum SortOption: String, CaseIterable, Identifiable {
        case none = "Default"
        case percentAscending = "Percentage ↑"
        case percentDescending = "Percentage ↓"
        
        var id: String { rawValue }
    }
    
    var filteredStocks: [Stock] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        var result = stocks
        
        // Apply search filter
        if !query.isEmpty {
            result = result.filter { stock in
                stock.name.localizedCaseInsensitiveContains(query)
            }
        }
        
        // Apply sorting by percentage change
        switch sortOption {
        case .percentAscending:
            result.sort { ($0.changePercentValue ?? 0) < ($1.changePercentValue ?? 0) }
        case .percentDescending:
            result.sort { ($0.changePercentValue ?? 0) > ($1.changePercentValue ?? 0) }
        case .none:
            break
        }
        
        return result
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
