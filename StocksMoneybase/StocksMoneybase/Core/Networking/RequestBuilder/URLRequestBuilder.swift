//
//  URLRequestBuilder.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 27/03/2026.
//

import Foundation

protocol RequestBuilding {
    func buildRequest(from endpoint: any APIEndpoint) throws -> URLRequest
}

struct URLRequestBuilder: RequestBuilding {
    func buildRequest(from endpoint: any APIEndpoint) throws -> URLRequest {
        guard var components = URLComponents(string: endpoint.baseURL + endpoint.path) else {
            throw NetworkError.invalidURL
        }
        components.queryItems = endpoint.queryItems
        guard let url = components.url else { throw NetworkError.invalidURL }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }

        return request
    }
}
