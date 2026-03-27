//
//  GetStocksUseCase.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 26/03/2026.
//

protocol GetMarketSummaryUseCase {
    func execute() async throws -> [MarketSummaryItem]
}
