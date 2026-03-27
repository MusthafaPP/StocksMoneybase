import Foundation

// MARK: - Local Data Source Implementation
final class LocaDataSourceImpl: DataSource {

    private let service: any APIServiceProtocol

    init(service: any APIServiceProtocol) {
        self.service = service
    }
    func fetchData<E: APIEndpoint>(apiEndpoint: E) async throws -> E.Response{
    // TODO: Implement from local db
        let response = try await service.fetch(apiEndpoint)
        return response
    }
}
