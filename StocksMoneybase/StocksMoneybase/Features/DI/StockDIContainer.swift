//
//  StockDIContainer.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 26/03/2026.
//

import SwiftUI
final class MarketSummaryDIContainer {
    static func makeMarketSummaryListView() -> some View {
        let remote = MarketSummaryRemoteDataSourceImp()
        let repository = MarketSummaryRepositoryImp(dataSource: remote)
        let useCase = GetMarketSummaryUseCaseImp(repository: repository)
        let viewModel = MarketSummaryListViewModel(useCase: useCase)
        return MarketSummaryListView(viewModel: viewModel)
    }
    
    static func makeMarketSummaryDetailView(marketSummary: MarketSummaryItem) -> some View {
        let remote = MarketSummaryRemoteDataSourceImp()
        let repository = MarketSummaryRepositoryImp(dataSource: remote)
        let useCase = GetMarketSummaryUseCaseImp(repository: repository)
        let viewModel = MarketSummaryDetailViewModel(
            symbol: marketSummary.symbol,
            initialName: marketSummary.shortName ?? marketSummary.fullExchangeName,
            useCase: useCase
        )
        return MarketSummaryDetailView(viewModel: viewModel)
    }
}
