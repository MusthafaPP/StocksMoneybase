//
//  StockDetailUseCase.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 27/03/2026.
//


protocol StockDetailsUseCase {
    func execute(symbol: String) async throws -> StockDetails
}
