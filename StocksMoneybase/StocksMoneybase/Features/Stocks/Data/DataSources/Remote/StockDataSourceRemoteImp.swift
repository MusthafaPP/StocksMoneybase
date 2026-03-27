import Foundation

// MARK: - Remote Data Source Implementation
final class MarketSummaryRemoteDataSourceImp: MarketSummaryDataSource {

    private let service: MarketSummaryService

    init(service: MarketSummaryService = MarketSummaryService()) {
        self.service = service
    }

    func fetchMarketSummary() async throws -> MarketSummaryResponse {
        // Use MarketSummaryService to fetch real API data
        let marketSummaryResponse = try await service.fetch(MarketSummaryEndpoint())
        return marketSummaryResponse
    }
}
