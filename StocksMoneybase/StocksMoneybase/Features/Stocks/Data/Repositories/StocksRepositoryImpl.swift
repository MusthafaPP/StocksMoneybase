//
//  StockRepositoryImp.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 26/03/2026.
//

final class StocksRepositoryImpl: StocksRepository {
    
    private let dataSource: DataSource
    
    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
    
    func fetchMarketSummary() async throws -> [Stock] {
        let response: StocksResponse = try await dataSource.fetchData(
            apiEndpoint: StocksEndpoint()
        )
        return response.marketSummary.result.map(StockMapper.mapToStock)
    }
}


