import Foundation
@testable import StocksMoneybase

enum MockError: Error {
    case someFailure
}

//struct InvalidEndpoint: APIEndpoint {
//    typealias Response = MarketSummaryResponse
//    let baseURL = ":// bad url"
//    let path = "/x"
//    let method: HTTPMethod = .get
//    let queryItems: [URLQueryItem]? = nil
//    let headers: [String: String]? = nil
//}

struct InvalidEndpoint: APIEndpoint {
    typealias Response = MarketSummaryResponse

    var baseURL: String { "ht tp://invalid-url" } // space breaks it
    var path: String { "" }
    var method: HTTPMethod { .get }
    var queryItems: [URLQueryItem]? { nil }
    var headers: [String: String]? { nil }
}

final class MarketSummaryDataSourceMock: MarketSummaryDataSource {
    private let result: Result<MarketSummaryResponse, Error>
    private(set) var callCount = 0

    init(result: Result<MarketSummaryResponse, Error>) {
        self.result = result
    }

    func fetchMarketSummary() async throws -> MarketSummaryResponse {
        callCount += 1
        return try result.get()
    }
}

final class MarketSummaryRepositoryMock: MarketSummaryRepository {
    private let result: Result<[MarketSummaryItem], Error>
    private(set) var callCount = 0

    init(result: Result<[MarketSummaryItem], Error>) {
        self.result = result
    }

    func fetchMarketSummary() async throws -> [MarketSummaryItem] {
        callCount += 1
        return try result.get()
    }
}

final class GetMarketSummaryUseCaseMock: GetMarketSummaryUseCase {
    private let result: Result<[MarketSummaryItem], Error>
    private(set) var callCount = 0

    init(result: Result<[MarketSummaryItem], Error>) {
        self.result = result
    }

    func execute() async throws -> [MarketSummaryItem] {
        callCount += 1
        return try result.get()
    }
}

func makeItem(
    symbol: String,
    shortName: String?,
    fullExchangeName: String = "NasdaqGS"
) -> MarketSummaryItem {
    MarketSummaryItem(
        fullExchangeName: fullExchangeName,
        symbol: symbol,
        gmtOffSetMilliseconds: nil,
        language: nil,
        regularMarketTime: nil,
        quoteType: nil,
        spark: nil,
        tradeable: nil,
        regularMarketPreviousClose: nil,
        exchangeTimezoneName: nil,
        cryptoTradeable: nil,
        exchangeDataDelayedBy: nil,
        firstTradeDateMilliseconds: nil,
        exchangeTimezoneShortName: nil,
        hasPrePostMarketData: nil,
        customPriceAlertConfidence: nil,
        regularMarketPrice: nil,
        marketState: nil,
        market: nil,
        priceHint: nil,
        exchange: nil,
        sourceInterval: nil,
        shortName: shortName,
        region: nil,
        triggerable: nil
    )
}
