////
////  ViewModelTests.swift
////  StocksMoneybaseTests
////
////  Created by Muhammed Musthafa on 26/03/2026.
////
//
//import Testing
//@testable import StocksMoneybase
//
//@Suite("View Models")
//struct ViewModelTests {
//
//    // MARK: - StockListViewModel Tests
//
//    @Test("List view model returns all items when search text is empty or whitespace")
//    @MainActor
//    func listViewModelEmptySearch() {
//        let useCase = GetMarketSummaryUseCaseMock(result: .success([]))
//        let viewModel = StockListViewModel(useCase: useCase)
//        
//        viewModel.stocks = [
//            makeStockPositive(),
//            makeStockNegative()
//        ]
//        viewModel.searchText = "   "   // whitespace only
//        
//        #expect(viewModel.filteredStocks.count == 2)
//    }
//
//    @Test("List view model filters by name/shortName case-insensitively")
//    @MainActor
//    func listViewModelFiltersByShortName() {
//        let useCase = GetMarketSummaryUseCaseMock(result: .success([]))
//        let viewModel = StockListViewModel(useCase: useCase)
//        
//        viewModel.stocks = [
//            makeStock(symbol: "AAPL", shortName: "Apple Inc."),
//            makeStock(symbol: "MSFT", shortName: "Microsoft Corporation"),
//            makeStock(symbol: "GOOGL", shortName: "Alphabet Inc.")
//        ]
//        viewModel.searchText = "apple"
//        
//        #expect(viewModel.filteredStocks.count == 1)
//        #expect(viewModel.filteredStocks.first?.symbol == "AAPL")
//    }
//
//    @Test("List view model filters using name when shortName is nil")
//    @MainActor
//    func listViewModelFiltersByNameFallback() {
//        let useCase = GetMarketSummaryUseCaseMock(result: .success([]))
//        let viewModel = StockListViewModel(useCase: useCase)
//        
//        viewModel.stocks = [
//            makeStock(symbol: "^DJI", shortName: nil, name: "Dow Jones Industrial Average"),
//            makeStock(symbol: "^IXIC", shortName: "Nasdaq Composite")
//        ]
//        viewModel.searchText = "dow"
//        
//        #expect(viewModel.filteredStocks.count == 1)
//        #expect(viewModel.filteredStocks.first?.symbol == "^DJI")
//    }
//
//    @Test("List view model loads data successfully")
//    @MainActor
//    func listViewModelLoadSuccess() async {
//        let stocks = [
//            makeStockPositive(),
//            makeStockNegative()
//        ]
//        let useCase = GetMarketSummaryUseCaseMock(result: .success(stocks))
//        let viewModel = StockListViewModel(useCase: useCase)
//
//        await viewModel.loadMarketSummaries()
//
//        #expect(viewModel.isLoading == false)
//        #expect(viewModel.stocks.count == 2)
//        #expect(useCase.callCount == 1)
//    }
//
//    @Test("List view model clears stocks on load failure")
//    @MainActor
//    func listViewModelLoadFailure() async {
//        let useCase = GetMarketSummaryUseCaseMock(result: .failure(MockError.someFailure))
//        let viewModel = StockListViewModel(useCase: useCase)
//
//        await viewModel.loadMarketSummaries()
//
//        #expect(viewModel.isLoading == false)
//        #expect(viewModel.stocks.isEmpty)
//        #expect(useCase.callCount == 1)
//    }
//
//    // MARK: - Sorting Tests
//
//    @Test("List view model sorts by percentage change descending")
//    @MainActor
//    func listViewModelSortsByPercentDescending() {
//        let useCase = GetMarketSummaryUseCaseMock(result: .success([]))
//        let viewModel = StockListViewModel(useCase: useCase)
//        
//        viewModel.stocks = [
//            makeStock(symbol: "AAPL", shortName: "Apple", changePercentValue: 1.5),
//            makeStock(symbol: "TSLA", shortName: "Tesla", changePercentValue: -3.2),
//            makeStock(symbol: "MSFT", shortName: "Microsoft", changePercentValue: 0.8)
//        ]
//        
//        viewModel.sortOption = .percentDescending
//        
//        let filtered = viewModel.filteredStocks
//        
//        #expect(filtered[0].symbol == "AAPL")   // Highest positive
//        #expect(filtered[1].symbol == "MSFT")
//        #expect(filtered[2].symbol == "TSLA")   // Negative
//    }
//
//    @Test("List view model sorts by percentage change ascending")
//    @MainActor
//    func listViewModelSortsByPercentAscending() {
//        let useCase = GetMarketSummaryUseCaseMock(result: .success([]))
//        let viewModel = StockListViewModel(useCase: useCase)
//        
//        viewModel.stocks = [
//            makeStock(symbol: "AAPL", shortName: "Apple", changePercentValue: 1.5),
//            makeStock(symbol: "TSLA", shortName: "Tesla", changePercentValue: -3.2),
//            makeStock(symbol: "MSFT", shortName: "Microsoft", changePercentValue: 0.8)
//        ]
//        
//        viewModel.sortOption = .percentAscending
//        
//        let filtered = viewModel.filteredStocks
//        
//        #expect(filtered[0].symbol == "TSLA")   // Most negative first
//        #expect(filtered[1].symbol == "MSFT")
//        #expect(filtered[2].symbol == "AAPL")
//    }
//
//    // MARK: - StockDetailViewModel Tests
//
//    @Test("Detail view model loads stock by symbol successfully")
//    @MainActor
//    func detailViewModelLoadSuccess() async {
//        let stocks = [
//            makeStock(symbol: "AAPL", shortName: "Apple Inc."),
//            makeStock(symbol: "MSFT", shortName: "Microsoft Corporation")
//        ]
//        let useCase = GetMarketSummaryUseCaseMock(result: .success(stocks))
//        
//        let viewModel = StockDetailViewModel(
//            symbol: "MSFT",
//            initialName: "Microsoft Corporation",
//            useCase: useCase
//        )
//
//        await viewModel.loadDetail()
//
//        #expect(viewModel.isLoading == false)
//        #expect(viewModel.errorMessage == nil)
//        #expect(viewModel.detail?.symbol == "MSFT")
//        #expect(useCase.callCount == 1)
//    }
//
//    @Test("Detail view model sets not found message when symbol is not present")
//    @MainActor
//    func detailViewModelSymbolNotFound() async {
//        let stocks = [makeStock(symbol: "TSLA", shortName: "Tesla, Inc.")]
//        let useCase = GetMarketSummaryUseCaseMock(result: .success(stocks))
//        
//        let viewModel = StockDetailViewModel(
//            symbol: "META",
//            initialName: "Meta Platforms",
//            useCase: useCase
//        )
//
//        await viewModel.loadDetail()
//
//        #expect(viewModel.detail == nil)
//        #expect(viewModel.errorMessage?.contains("META") == true)
//    }
//
//    @Test("Detail view model shows user-friendly error on failure")
//    @MainActor
//    func detailViewModelLoadFailure() async {
//        let useCase = GetMarketSummaryUseCaseMock(result: .failure(MockError.someFailure))
//        
//        let viewModel = StockDetailViewModel(
//            symbol: "AAPL",
//            initialName: "Apple Inc.",
//            useCase: useCase
//        )
//
//        await viewModel.loadDetail()
//
//        #expect(viewModel.detail == nil)
//        #expect(viewModel.errorMessage == "Unable to load stock details. Pull to retry.")
//        #expect(viewModel.isLoading == false)
//    }
//}

import XCTest
import SwiftUI
import Combine
@testable import StocksMoneybase // ⚠️ Ensure this matches your project name

// MARK: - Mocks
// These simulate your UseCase protocols without making network calls.

class MockStockDetailsUseCase: StockDetailsUseCase {
    var result: Result<StockDetails, Error> = .failure(NSError(domain: "Mock", code: -1))
    
    func execute(symbol: String) async throws -> StockDetails {
        switch result {
        case .success(let details): return details
        case .failure(let error): throw error
        }
    }
}

class MockStocksUseCase: StocksUseCase {
    var result: Result<[Stock], Error> = .failure(NSError(domain: "Mock", code: -1))
    
    func execute() async throws -> [Stock] {
        switch result {
        case .success(let stocks): return stocks
        case .failure(let error): throw error
        }
    }
}

// MARK: - Tests

@MainActor
final class StocksMoneybaseTests: XCTestCase {
    
    // MARK: - StockListViewModel Tests
    
    func testList_Filtering_ReturnsOnlyMatchingStocks() async {
        // Arrange
        let stocks = [
            createDummyStock(symbol: "AAPL", name: "Apple Inc"),
            createDummyStock(symbol: "TSLA", name: "Tesla"),
            createDummyStock(symbol: "GOOG", name: "Alphabet")
        ]
        let mockUseCase = MockStocksUseCase()
        mockUseCase.result = .success(stocks)
        let sut = StockListViewModel(useCase: mockUseCase)
        
        await sut.loadMarketSummaries()
        
        // Act
        sut.searchText = "tes"
        
        // Assert
        XCTAssertEqual(sut.filteredStocks.count, 1)
        XCTAssertEqual(sut.filteredStocks.first?.symbol, "TSLA")
    }
    
    func testList_Sorting_PercentageDescending() async {
        // Arrange
        let low = createDummyStock(symbol: "LOW", name: "Low Stock", percent: -5.0)
        let high = createDummyStock(symbol: "HIGH", name: "High Stock", percent: 10.0)
        let mockUseCase = MockStocksUseCase()
        mockUseCase.result = .success([low, high])
        let sut = StockListViewModel(useCase: mockUseCase)
        
        await sut.loadMarketSummaries()
        
        // Act
        sut.sortOption = .percentDescending
        
        // Assert
        XCTAssertEqual(sut.filteredStocks.first?.symbol, "HIGH")
    }
    
    // MARK: - StockDetailViewModel Tests
    
    func testDetail_LoadingFlow_UpdatesStateCorrectly() async {
        // Arrange
        let expectedSymbol = "AAPL"
        let mockDetails = createDummyStockDetails(symbol: expectedSymbol)
        let mockUseCase = MockStockDetailsUseCase()
        mockUseCase.result = .success(mockDetails)
        
        let sut = StockDetailViewModel(symbol: expectedSymbol, initialName: "Apple", useCase: mockUseCase)
        
        // Act
        await sut.loadDetail()
        
        // Assert
        XCTAssertEqual(sut.detail?.identity.symbol, expectedSymbol)
        XCTAssertNil(sut.errorMessage)
        XCTAssertFalse(sut.isLoading)
    }
    
    func testDetail_ErrorHandling_SetsErrorMessage() async {
        // Arrange
        let mockUseCase = MockStockDetailsUseCase()
        mockUseCase.result = .failure(NSError(domain: "API", code: 500))
        let sut = StockDetailViewModel(symbol: "AAPL", initialName: "Apple", useCase: mockUseCase)
        
        // Act
        await sut.loadDetail()
        
        // Assert
        XCTAssertNotNil(sut.errorMessage)
        XCTAssertEqual(sut.errorMessage, "Unable to load stock details. Pull to retry.")
    }

    // MARK: - Helper Factories
    
    /// Creates a Stock object with default values for test purposes
    private func createDummyStock(symbol: String, name: String, percent: Double = 0.0) -> Stock {
        return Stock(
            symbol: symbol,
            name: name,
            shortName: name,
            priceText: "$100.00",
            previousCloseText: "$99.00",
            changeValue: 1.0,
            changeText: "+1.00",
            changePercentValue: percent,
            changePercentText: "\(percent)%",
            fullExchangeName: "NASDAQ",
            region: "US",
            marketState: "REGULAR",
            quoteType: "EQUITY",
            tradeable: true,
            priceHint: 2,
            sourceInterval: 15
        )
    }
    
    /// Creates a StockDetails object with default values to satisfy nested struct requirements
    private func createDummyStockDetails(symbol: String) -> StockDetails {
        let period = StockDetails.Period(timezone: "UTC", start: 0, end: 0, gmtOffset: 0)
        let tradingP = StockDetails.TradingPeriod(pre: period, regular: period, post: period)
        let tradingPs = StockDetails.TradingPeriods(pre: [[period]], regular: [[period]], post: [[period]])
        
        return StockDetails(
            identity: .init(symbol: symbol, shortName: "S", longName: "Long", instrumentType: "EQUITY"),
            pricing: .init(currency: "USD", currentPrice: 100, previousClose: 90, chartPreviousClose: 90, priceHint: 2, scale: 1, open: [], close: [], high: [], low: [], volume: []),
            range: .init(dayHigh: 110, dayLow: 90, fiftyTwoWeekHigh: 150, fiftyTwoWeekLow: 80),
            volume: .init(regularMarketVolume: 1000),
            market: .init(exchangeName: "NAS", fullExchangeName: "Nasdaq", timezone: "EST", exchangeTimezoneName: "NY", gmtOffset: 0),
            trading: .init(firstTradeDate: 0, regularMarketTime: 0, hasPrePostMarketData: false, currentTradingPeriod: tradingP, tradingPeriods: tradingPs),
            metadata: .init(dataGranularity: "1d", range: "1mo", validRanges: []),
            timestamps: []
        )
    }
}
