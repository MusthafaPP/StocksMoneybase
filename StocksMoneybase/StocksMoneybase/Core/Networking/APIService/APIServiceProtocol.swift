//
//  APIServiceProtocol.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 27/03/2026.
//


import Foundation

protocol APIServiceProtocol {
    var client: NetworkClient { get }
}

extension APIServiceProtocol {
    func fetch<Endpoint: APIEndpoint>(_ endpoint: Endpoint) async throws -> Endpoint.Response {
        try await client.request(endpoint)
    }
}

final class MarketSummaryService: APIServiceProtocol {
    let client: NetworkClient
    init(client: NetworkClient = URLSessionClient()) {
        self.client = client
    }
}
