import Testing
@testable import StocksMoneybase

@Suite("Repository and Use Case")
struct RepositoryAndUseCaseTests {

    @Test("Repository maps response result")
    func repositoryReturnsResultFromResponse() async throws {
        let item = makeItem(symbol: "SPY", shortName: "SPDR")
        let dataSource = MarketSummaryDataSourceMock(result: .success(StocksResponse(
            marketSummary: StocksSummary(result: [item], error: nil)
        )))
        let repository = StocksRepositoryImpl(dataSource: dataSource)

        let result = try await repository.fetchMarketSummary()

        #expect(result.count == 1)
        #expect(result.first?.symbol == "SPY")
        #expect(dataSource.callCount == 1)
    }

    @Test("Repository propagates data source error")
    func repositoryPropagatesError() async {
        let dataSource = MarketSummaryDataSourceMock(result: .failure(MockError.someFailure))
        let repository = StocksRepositoryImpl(dataSource: dataSource)

        await #expect(throws: Error.self) {
            _ = try await repository.fetchMarketSummary()
        }
        #expect(dataSource.callCount == 1)
    }

    @Test("Use case forwards repository result")
    func useCaseReturnsRepositoryData() async throws {
        let repository = MarketSummaryRepositoryMock(result: .success([makeStock(symbol: "QQQ", shortName: "Invesco")]))
        let useCase = StocksUseCaseImpl(repository: repository)

        let result = try await useCase.execute()

        #expect(result.count == 1)
        #expect(result[0].symbol == "QQQ")
        #expect(repository.callCount == 1)
    }

    @Test("Use case propagates repository error")
    func useCasePropagatesError() async {
        let repository = MarketSummaryRepositoryMock(result: .failure(MockError.someFailure))
        let useCase = StocksUseCaseImpl(repository: repository)

        await #expect(throws: Error.self) {
            _ = try await useCase.execute()
        }
        #expect(repository.callCount == 1)
    }
}
