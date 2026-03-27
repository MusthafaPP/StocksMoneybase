//
//  MarketSummaryEndpoint.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 27/03/2026.
//

import Foundation


struct MarketSummaryEndpoint: APIEndpoint {
    typealias Response = MarketSummaryResponse
    
    var baseURL: String { "https://yh-finance.p.rapidapi.com" }
    var path: String { "/market/v2/get-summary" }
    var method: HTTPMethod { .get }
    var queryItems: [URLQueryItem]? { [URLQueryItem(name: "region", value: "US")] }
    var headers: [String : String]? {
        [
            "Content-Type": "application/json",
            "x-rapidapi-host": "yh-finance.p.rapidapi.com",
            "x-rapidapi-key": "501a9ce445msh7a4209530a3dd9dp1dcc1djsn116323932be5"
        ]
    }
}


