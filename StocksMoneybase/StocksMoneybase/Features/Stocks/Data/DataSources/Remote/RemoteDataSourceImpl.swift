import Foundation

// MARK: - Remote Data Source Implementation
final class RemoteDataSourceImpl: DataSource {

    private let service: any APIServiceProtocol

    init(service: any APIServiceProtocol) {
        self.service = service
    }
    func fetchData<E: APIEndpoint>(apiEndpoint: E) async throws -> E.Response {
        // Use APIService to fetch real API data
        let response = try await service.fetch(apiEndpoint)
        return response
    }
}
