import SwiftUI
import Combine
@MainActor
final class StockDetailViewModel: ObservableObject {
    @Published var detail: StockDetails?       // ✅ Changed from Stock
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    let symbol: String
    let initialName: String
    
    private let useCase: StockDetailsUseCase   // Make sure this returns StockDetails
    
    init(symbol: String, initialName: String, useCase: StockDetailsUseCase) {
        self.symbol = symbol
        self.initialName = initialName
        self.useCase = useCase
    }
    
    func loadDetail() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        
        do {
            let stockDetails = try await useCase.execute(symbol: symbol)
            // Since StockDetailsRepository returns a single StockDetails now:
            detail = stockDetails
        } catch {
            errorMessage = "Unable to load stock details. Pull to retry."
        }
    }
}
