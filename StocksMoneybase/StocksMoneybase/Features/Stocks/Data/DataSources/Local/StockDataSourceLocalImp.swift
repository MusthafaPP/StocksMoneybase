import Foundation

// MARK: - Local Data Source Implementation
final class MarketSummaryLocalDataSourceImp: MarketSummaryDataSource {

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
