//
//  StockDetailsRepository.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 27/03/2026.
//


protocol StockDetailsRepository {
    func fetchStockDetails(symbol: String) async throws -> StockDetails
}
