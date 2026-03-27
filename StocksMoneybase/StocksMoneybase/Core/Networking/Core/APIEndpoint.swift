//
//  APIEndpoint.swift.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 27/03/2026.
//

import Foundation

protocol APIEndpoint {
    associatedtype Response: Decodable

    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var headers: [String: String]? { get }
}
