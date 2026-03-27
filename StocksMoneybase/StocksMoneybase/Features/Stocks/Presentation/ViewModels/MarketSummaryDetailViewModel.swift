import SwiftUI
import Combine
@MainActor
final class MarketSummaryDetailViewModel: ObservableObject {
    @Published var detail: MarketSummaryItem?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    let symbol: String
    let initialName: String
    
    private let useCase: GetMarketSummaryUseCase
    
    init(symbol: String, initialName: String, useCase: GetMarketSummaryUseCase) {
        self.symbol = symbol
        self.initialName = initialName
        self.useCase = useCase
    }
    
    func loadDetail() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        
        do {
            let summaries = try await useCase.execute()
            detail = summaries.first(where: { $0.symbol == symbol })
            if detail == nil {
                errorMessage = "Unable to find stock details for \(symbol)."
            }
        } catch {
            errorMessage = "Unable to load stock details. Pull to retry."
        }
    }
}
