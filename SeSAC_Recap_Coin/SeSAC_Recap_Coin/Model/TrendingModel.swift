//
//  TrendingModel.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 2/27/24.
//

import Foundation

struct TrendingModel: Decodable {
    let coins: [TrendingCoin]
    let nfts: [NFT]
}

struct TrendingCoin: Decodable {
    let item: CoinItem
}

struct CoinItem: Decodable {
    let id: String  // 코인 ID
    let name: String    // 코인 이름
    let symbol: String  // 코인 통화 단위
    let iconStr: String // 코인 아이콘 리소스
    let data: CoinData
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case iconStr = "small"
        case data
    }
}

struct CoinData: Decodable {
    let price: String   // 코인 현재가
    let priceChangePer24h: PriceChangePer24H  // 코인 변동폭
    
    enum CodingKeys: String, CodingKey {
        case price
        case priceChangePer24h = "price_change_percentage_24h"
    }
}

// 변동폭
struct PriceChangePer24H: Decodable {
    let krw: Double
}

struct NFT: Decodable {
    let name: String    // NFT 토큰명
    let symbol: String  // NFT 통화 단위
    let iconStr: String // NFT 아이콘 리소스
    let data: NFTData
    
    enum CodingKeys: String, CodingKey {
        case name
        case symbol
        case iconStr = "thumb"
        case data
    }
}

struct NFTData: Decodable {
    let lowPrice: String   // NFT 최저가
    let lowPriceChangePer24h: String  // NFT 변동폭
    
    enum CodingKeys: String, CodingKey {
        case lowPrice = "floor_price"
        case lowPriceChangePer24h = "floor_price_in_usd_24h_percentage_change"
    }
}


