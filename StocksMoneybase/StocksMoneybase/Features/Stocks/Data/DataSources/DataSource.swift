//
//  MarketSummaryDataSource.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 27/03/2026.
//


protocol DataSource {
    func fetchData<E: APIEndpoint>(apiEndpoint: E) async throws -> E.Response
}
