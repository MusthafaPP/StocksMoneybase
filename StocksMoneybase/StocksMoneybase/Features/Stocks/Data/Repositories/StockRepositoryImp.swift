//
//  StockRepositoryImp.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 26/03/2026.
//

final class MarketSummaryRepositoryImp: MarketSummaryRepository {
    
    private let dataSource: MarketSummaryDataSource
    
    init(dataSource: MarketSummaryDataSource) {
        self.dataSource = dataSource
    }
    
    func fetchMarketSummary() async throws -> [MarketSummaryItem] {
        let response = try await dataSource.fetchMarketSummary()
        return response.marketSummary.result
    }
}
