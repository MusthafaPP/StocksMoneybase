//
//  ChartEndpoint.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 27/03/2026.
//

import Foundation


struct ChartEndpoint: APIEndpoint {
    typealias Response = ChartResponse
    
    let symbol: String
    
    var baseURL: String { "https://yh-finance.p.rapidapi.com" }
    var path: String { "/stock/v2/get-chart" }
    var method: HTTPMethod { .get }
    var queryItems: [URLQueryItem]? {
        [
            URLQueryItem(name: "interval", value: "5m"),
            URLQueryItem(name: "symbol", value: symbol),
            URLQueryItem(name: "range", value: "1d"),
            URLQueryItem(name: "region", value: "US")
        ]
    }
    var headers: [String : String]? {
        [
            "Content-Type": "application/json",
            "x-rapidapi-host": "yh-finance.p.rapidapi.com",
            "x-rapidapi-key": "501a9ce445msh7a4209530a3dd9dp1dcc1djsn116323932be5"
        ]
    }
}


