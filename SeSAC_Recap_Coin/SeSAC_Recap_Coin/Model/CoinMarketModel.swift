//
//  CoinMarketModel.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 2/27/24.
//

import Foundation

typealias CoinMarketModel = [CoinMarketData]

struct CoinMarketData: Decodable {
    let id: String  // 코인 ID
    let name: String    // 코인 이름
    let symbol: String  // 코인 통화 단위
    let iconStr: String // 코인 아이콘 리소스
    let currentPrice: Int    // 코인 현재가 (시가)
    let priceChangePer24h: Double    // 코인 변동폭
    let low24h: Int // 코인 저가
    let high24h: Int // 코인 저가
    let ath: Int // 코인 사상 최고가 (신고점, All-Time High)
    let athDate: String    // 신고점 일자
    let atl: Int // 코인 사상 최저가 (신저점, All-Time Low)
    let atlDate: String    // 신저점 일자
    let lastUpdated: String    // 코인 시장 데이터 업데이트 시각
    let sparklineIn7d: SparklineIn7d?  // 일주일 간 코인 시세 정보(쿼리 sparkline=true일 때만)
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case iconStr = "image"
        case currentPrice = "current_price"
        case priceChangePer24h = "price_change_percentage_24h"
        case low24h = "low_24h"
        case high24h = "high_24h"
        case ath
        case athDate = "ath_date"
        case atl
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7d = "sparkline_in_7d"
    }
}

struct SparklineIn7d: Decodable {
    let price: [Double]
}
