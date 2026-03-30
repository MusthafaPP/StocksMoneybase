//
//  NetworkClient.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 27/03/2026.
//

import Foundation

protocol NetworkClient {
    func request<Endpoint: APIEndpoint>(_ endpoint: Endpoint) async throws -> Endpoint.Response
}


import Foundation

final class URLSessionClient: NetworkClient {
    
    private let requestBuilder: RequestBuilding
    
    init(requestBuilder: RequestBuilding = URLRequestBuilder()) {
        self.requestBuilder = requestBuilder
    }
    
    func request<Endpoint: APIEndpoint>(_ endpoint: Endpoint) async throws -> Endpoint.Response {
        let request = try requestBuilder.buildRequest(from: endpoint)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let dataString = String(data: data, encoding: .utf8) {
                print(dataString)
            } else {
                print("Failed to convert data to string")
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.statusCode(httpResponse.statusCode)
            }
            
            do {
                return try JSONDecoder().decode(Endpoint.Response.self, from: data)
            } catch {
                throw NetworkError.decodingError(error)
            }
        } catch {
            throw NetworkError.requestFailed(error)
        }
    }
}
