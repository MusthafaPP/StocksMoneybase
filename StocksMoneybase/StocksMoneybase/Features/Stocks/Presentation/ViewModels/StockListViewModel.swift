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
    @Published var isInitialLoading = false
    
    private let useCase: StocksUseCase
    private var pollingTask: Task<Void, Never>?   // 👈 important
    
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
        
        if !query.isEmpty {
            result = result.filter {
                $0.name.localizedCaseInsensitiveContains(query)
            }
        }
        
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
    
    // MARK: - Polling
    
    func startPolling() {
        stopPolling()
        
        pollingTask = Task {
            await loadMarketSummaries(isInitial: true)
            
            while !Task.isCancelled {
                let start = Date()
                
                await loadMarketSummaries(isInitial: false)
                
                let elapsed = Date().timeIntervalSince(start)
                let delay = max(0, 8 - elapsed)
                
                try? await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
            }
        }
    }
    
    func stopPolling() {
        pollingTask?.cancel()
        pollingTask = nil
    }
    
    // MARK: - API
    
    func loadMarketSummaries(isInitial: Bool = false) async {
        if isInitial {
            isInitialLoading = true
        }
        
        defer {
            if isInitial {
                isInitialLoading = false
            }
        }
        
        do {
            stocks = try await useCase.execute()
        } catch {
            print("Error:", error)
        }
    }
}
