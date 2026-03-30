//
//  GetStocksUseCaseImp.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 26/03/2026.
//


final class StocksUseCaseImpl: StocksUseCase {
    
    private let repository: StocksRepository
    
    init(repository: StocksRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> [Stock] {
        try await repository.fetchMarketSummary()
    }
}
