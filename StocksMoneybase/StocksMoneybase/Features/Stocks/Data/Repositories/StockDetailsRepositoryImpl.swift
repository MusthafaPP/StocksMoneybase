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
        let response: ChartResponse = try await dataSource.fetchData(
            apiEndpoint: StockDetailsEndpoint(symbol: symbol)
        )
        // Assuming at least one result exists for the symbol; otherwise throw.
        guard let first = response.chart.result.first else {
            struct NoChartData: Error {}
            throw NoChartData()
        }
        return StockDetailsMapper.mapToStock(from: first)
    }
}
