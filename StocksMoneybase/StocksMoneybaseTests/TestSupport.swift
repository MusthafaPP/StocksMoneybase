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
    typealias Response = StocksResponse

    var baseURL: String { "ht tp://invalid-url" } // space breaks it
    var path: String { "" }
    var method: HTTPMethod { .get }
    var queryItems: [URLQueryItem]? { nil }
    var headers: [String: String]? { nil }
}

final class MarketSummaryDataSourceMock: DataSource {
    private let result: Result<StocksResponse, Error>
    private(set) var callCount = 0

    init(result: Result<StocksResponse, Error>) {
        self.result = result
    }

    func fetchMarketSummary() async throws -> StocksResponse {
        callCount += 1
        return try result.get()
    }
}

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

func makeItem(
    symbol: String,
    shortName: String?,
    fullExchangeName: String = "NasdaqGS"
) -> Stock {
    Stock(
        fullExchangeName: fullExchangeName,
        symbol: symbol,
        gmtOffSetMilliseconds: nil,
        language: nil,
        regularMarketTime: nil,
        quoteType: nil,
        spark: nil,
        tradeable: nil,
        regularMarketPreviousClose: nil,
        regularMarketChangePercent: nil,
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

func makeItemWithChangePercent(
    symbol: String,
    shortName: String?,
    changeRaw: Double?,
    changeFmt: String?,
    fullExchangeName: String = "NasdaqGS"
) -> Stock {
    let change = MarketChangePercent(raw: changeRaw, fmt: changeFmt)
    return Stock(
        fullExchangeName: fullExchangeName,
        symbol: symbol,
        gmtOffSetMilliseconds: nil,
        language: nil,
        regularMarketTime: nil,
        quoteType: nil,
        spark: nil,
        tradeable: nil,
        regularMarketPreviousClose: nil,
        regularMarketChangePercent: change,
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

func makeStock(
    symbol: String,
    shortName: String?,
    fullExchangeName: String = "NasdaqGS"
) -> Stock {
    StockMapper.mapToStock(makeItem(symbol: symbol, shortName: shortName, fullExchangeName: fullExchangeName))
}
