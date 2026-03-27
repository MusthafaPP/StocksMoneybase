//
//  StockDataSource.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 26/03/2026.
//

protocol MarketSummaryDataSource {
    func fetchMarketSummary() async throws -> MarketSummaryResponse
}
