//
//  GetStocksUseCase.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 26/03/2026.
//

protocol StocksUseCase {
    func execute() async throws -> [Stock]
}


