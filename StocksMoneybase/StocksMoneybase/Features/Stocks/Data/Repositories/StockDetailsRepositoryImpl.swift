//
//  StocksRepositoryImpl 2.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 27/03/2026.
//

import Foundation


final class StockDetailsRepositoryImpl: StockDetailsRepository {

    private let dataSource: DataSource

    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }

    func fetchStockDetails(symbol: String) async throws -> StockDetails {
        let response = try await dataSource.fetchData(
            apiEndpoint: StockDetailsEndpoint(symbol: symbol)
        )
        
        // Safely unwrap the first result
        guard let firstResult = response.chart.result.first else {
            throw NSError(domain: "StockDetailsRepository", code: 404, userInfo: [NSLocalizedDescriptionKey: "No stock data found"])
        }
        
        return StockDetailsMapper.mapToStock(from: firstResult)
    }
}
