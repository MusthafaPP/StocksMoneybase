//
//  StockDetailsUseCaseImpl.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 27/03/2026.
//


final class StockDetailsUseCaseImpl: StockDetailsUseCase {
    
    private let repository: StockDetailsRepository
    
    init(repository: StockDetailsRepository) {
        self.repository = repository
    }
    func execute(symbol: String) async throws -> StockDetails {
        try await repository.fetchStockDetails(symbol: symbol)
    }
}
