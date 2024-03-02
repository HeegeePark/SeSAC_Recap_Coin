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
    let currentPrice: NumericValue    // 코인 현재가 (시가)
    let priceChangePer24h: Double    // 코인 변동폭
    let low24h: NumericValue // 코인 저가
    let high24h: NumericValue // 코인 저가
    let ath: NumericValue // 코인 사상 최고가 (신고점, All-Time High)
    let athDate: String    // 신고점 일자
    let atl: NumericValue // 코인 사상 최저가 (신저점, All-Time Low)
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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.symbol = try container.decode(String.self, forKey: .symbol)
        self.iconStr = try container.decode(String.self, forKey: .iconStr)
        self.priceChangePer24h = try container.decode(Double.self, forKey: .priceChangePer24h)
        self.athDate = try container.decode(String.self, forKey: .athDate)
        self.atlDate = try container.decode(String.self, forKey: .atlDate)
        self.lastUpdated = try container.decode(String.self, forKey: .lastUpdated)
        self.sparklineIn7d = try container.decodeIfPresent(SparklineIn7d.self, forKey: .sparklineIn7d)
        
        if let intValue = try? container.decode(Int.self, forKey: .currentPrice) {
            self.currentPrice = .integer(intValue)
        } else if let doubleValue = try? container.decode(Double.self, forKey: .currentPrice) {
            self.currentPrice = .double(doubleValue)
        } else {
            throw DecodingError.dataCorruptedError(forKey: .ath, in: container, debugDescription: "Invalid currentPrice value")
        }
        
        if let intValue = try? container.decode(Int.self, forKey: .low24h) {
            self.low24h = .integer(intValue)
        } else if let doubleValue = try? container.decode(Double.self, forKey: .low24h) {
            self.low24h = .double(doubleValue)
        } else {
            throw DecodingError.dataCorruptedError(forKey: .low24h, in: container, debugDescription: "Invalid low24h value")
        }
        
        if let intValue = try? container.decode(Int.self, forKey: .high24h) {
            self.high24h = .integer(intValue)
        } else if let doubleValue = try? container.decode(Double.self, forKey: .high24h) {
            self.high24h = .double(doubleValue)
        } else {
            throw DecodingError.dataCorruptedError(forKey: .high24h, in: container, debugDescription: "Invalid high24h value")
        }
        
        if let intValue = try? container.decode(Int.self, forKey: .ath) {
            self.ath = .integer(intValue)
        } else if let doubleValue = try? container.decode(Double.self, forKey: .ath) {
            self.ath = .double(doubleValue)
        } else {
            throw DecodingError.dataCorruptedError(forKey: .ath, in: container, debugDescription: "Invalid ath value")
        }
        
        if let intValue = try? container.decode(Int.self, forKey: .atl) {
            self.atl = .integer(intValue)
        } else if let doubleValue = try? container.decode(Double.self, forKey: .atl) {
            self.atl = .double(doubleValue)
        } else {
            throw DecodingError.dataCorruptedError(forKey: .atl, in: container, debugDescription: "Invalid atl value")
        }
    }
}

struct SparklineIn7d: Decodable {
    let price: [Double]
}

enum NumericValue: Hashable {
    case integer(Int)
    case double(Double)
    
    var preprocessPrice: String {
        switch self {
        case .integer(let intValue):
            return intValue.preprocessPrice
        case .double(let doubleValue):
            return doubleValue.preprocessPrice
        }
    }
}
