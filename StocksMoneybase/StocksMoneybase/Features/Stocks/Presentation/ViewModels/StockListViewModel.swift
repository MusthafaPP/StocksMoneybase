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
    @Published var isLoading = false
    
    private let useCase: GetMarketSummaryUseCase
    
    init(useCase: GetMarketSummaryUseCase) {
        self.useCase = useCase
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
