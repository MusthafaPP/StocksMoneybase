//
//  StockRepository.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 26/03/2026.
//


protocol StocksRepository {
    func fetchMarketSummary() async throws -> [Stock]
}

