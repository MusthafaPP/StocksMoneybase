//
//  StockDIContainer.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 26/03/2026.
//

import SwiftUI
final class MarketSummaryDIContainer {
    static func makeMarketSummaryListView() -> some View {
        let apiService = APIService()
        let remote = RemoteDataSourceImpl(service: apiService)
        let repository = StocksRepositoryImpl(dataSource: remote)
        let useCase = StocksUseCaseImpl(repository: repository)
        let viewModel = MarketSummaryListViewModel(useCase: useCase)
        return MarketSummaryListView(viewModel: viewModel)
    }
    
    static func makeMarketSummaryDetailView(stock: Stock) -> some View {
        let apiService = APIService()
        let remote = RemoteDataSourceImpl(service: apiService)
        let repository = StockDetailsRepositoryImpl(dataSource: remote)
        let useCase = StockDetailsUseCaseImpl(repository: repository)
        let viewModel = StockDetailViewModel(
            symbol: stock.symbol,
            initialName: stock.name,
            useCase: useCase
        )
        return StockDetailView(viewModel: viewModel)
    }
}
