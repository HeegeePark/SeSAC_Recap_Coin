//
//  APIRouter.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 2/27/24.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    case trending
    case search(query: String)
    case coinMarket(ids: [String], sparkline: Bool)
    
    private var method: HTTPMethod {
        return .get
    }
    
    private var path: String {
        switch self {
        case .trending:
            return "search/trending"
        case .search:
            return "search"
        case .coinMarket:
            return "coins/markets"
        }
    }
    
    private var parameters: Parameters? {
        switch self {
        case .trending:
            return nil
        case .search(let query):
            return ["query": query]
        case .coinMarket(let ids, let sparkline):
            return [
                "vs_currency": "krw",
                "ids": ids.joined(separator: ","),
                "sparkline": sparkline.description
            ]
        }
    }
    
    private var encoding: URLEncoding {
        return URLEncoding(destination: .queryString)
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = APIConstants.baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.method = method
        
        if let parameters = parameters {
            return try encoding.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}
