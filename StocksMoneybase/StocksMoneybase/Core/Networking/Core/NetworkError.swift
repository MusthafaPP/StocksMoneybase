//
//  NetworkError.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 27/03/2026.
//

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingError(Error)
    case statusCode(Int)
}

