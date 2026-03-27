//
//  TestHelpers.swift
//  StocksMoneybaseTests
//
//  Created by Muhammed Musthafa on 26/03/2026.
//

import Foundation
@testable import StocksMoneybase

enum MockError: Error {
    case someFailure
}

struct InvalidEndpoint: APIEndpoint {
    typealias Response = StocksResponse
    
    var baseURL: String { "http://invalid-url" }
    var path: String { "" }
    var method: HTTPMethod { .get }
    var queryItems: [URLQueryItem]? { nil }
    var headers: [String: String]? { nil }
}

// MARK: - DataSource Mock (Fixed)

final class StocksDataSourceMock: DataSource {
    private let result: Result<StocksResponse, Error>
    private(set) var callCount = 0
    
    init(result: Result<StocksResponse, Error>) {
        self.result = result
    }
    
    /// Main generic method required by the DataSource protocol
    func fetchData<E>(apiEndpoint: E) async throws -> E.Response where E: APIEndpoint {
        callCount += 1
        
        // Safe cast - this mock is designed specifically for StocksResponse
        guard let response = try result.get() as? E.Response else {
            fatalError("""
                StocksDataSourceMock type mismatch.
                Expected response type: \(E.Response.self)
                Provided: StocksResponse
                """)
        }
        
        return response
    }
    
    /// Legacy convenience method (kept for backward compatibility)
    func fetchMarketSummary() async throws -> StocksResponse {
        callCount += 1
        return try result.get()
    }
}

// MARK: - Repository & UseCase Mocks

final class MarketSummaryRepositoryMock: StocksRepository {
    private let result: Result<[Stock], Error>
    private(set) var callCount = 0
    
    init(result: Result<[Stock], Error>) {
        self.result = result
    }
    
    func fetchMarketSummary() async throws -> [Stock] {
        callCount += 1
        return try result.get()
    }
}

final class GetMarketSummaryUseCaseMock: StocksUseCase {
    private let result: Result<[Stock], Error>
    private(set) var callCount = 0
    
    init(result: Result<[Stock], Error>) {
        self.result = result
    }
    
    func execute() async throws -> [Stock] {
        callCount += 1
        return try result.get()
    }
}

// MARK: - Modern Stock Factory

func makeStock(
    symbol: String,
    name: String? = nil,
    shortName: String?,
    priceText: String? = "150.25",
    previousCloseText: String? = "148.75",
    changeValue: Double? = 1.50,
    changePercentValue: Double? = 1.01,
    changePercentText: String? = "+1.01%"
) -> Stock {
    
    let displayName = name ?? shortName ?? symbol
    
    return Stock(
        symbol: symbol,
        name: displayName,
        shortName: shortName,
        
        priceText: priceText,
        previousCloseText: previousCloseText,
        
        changeValue: changeValue,
        changeText: changeValue.map { String(format: "%.2f", $0) },
        
        changePercentValue: changePercentValue,
        changePercentText: changePercentText,
        
        // Required detail fields
        fullExchangeName: "NASDAQ",
        region: "US",
        marketState: "REGULAR",
        quoteType: "EQUITY",
        tradeable: true,
        priceHint: 2,
        sourceInterval: 15
    )
}

// Convenient predefined stocks for tests

func makeStockPositive() -> Stock {
    makeStock(
        symbol: "AAPL",
        shortName: "Apple Inc.",
        priceText: "226.84",
        previousCloseText: "224.18",
        changeValue: 2.66,
        changePercentValue: 1.19,
        changePercentText: "+1.19%"
    )
}

func makeStockNegative() -> Stock {
    makeStock(
        symbol: "TSLA",
        shortName: "Tesla, Inc.",
        priceText: "412.50",
        previousCloseText: "428.30",
        changeValue: -15.80,
        changePercentValue: -3.69,
        changePercentText: "-3.69%"
    )
}

func makeStockNoChange() -> Stock {
    makeStock(
        symbol: "MSFT",
        shortName: "Microsoft Corporation",
        priceText: "415.00",
        previousCloseText: "415.00",
        changeValue: 0.0,
        changePercentValue: 0.0,
        changePercentText: "0.00%"
    )
}

// MARK: - Legacy Helpers (Deprecated)

func makeItem(
    symbol: String,
    shortName: String?,
    fullExchangeName: String = "NasdaqGS"
) -> Stock {
    fatalError("makeItem is deprecated. Use makeStock() instead.")
}

func makeItemWithChangePercent(
    symbol: String,
    shortName: String?,
    changeRaw: Double?,
    changeFmt: String?,
    fullExchangeName: String = "NasdaqGS"
) -> Stock {
    fatalError("makeItemWithChangePercent is deprecated. Use makeStock() instead.")
}

func makeStockLegacy(
    symbol: String,
    shortName: String?,
    fullExchangeName: String = "NasdaqGS"
) -> Stock {
    fatalError("makeStockLegacy is deprecated. Use makeStock() instead.")
}
