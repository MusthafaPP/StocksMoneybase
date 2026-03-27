//
//  GetStocksUseCaseImp.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 26/03/2026.
//


final class GetMarketSummaryUseCaseImp: GetMarketSummaryUseCase {
    
    private let repository: MarketSummaryRepository
    
    init(repository: MarketSummaryRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> [MarketSummaryItem] {
        try await repository.fetchMarketSummary()
    }
}