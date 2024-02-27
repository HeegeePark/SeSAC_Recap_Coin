//
//  SearchModel.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 2/27/24.
//

import Foundation

struct SearchModel: Decodable {
    let coins: [SearchCoin]
}

struct SearchCoin: Decodable {
    let id: String  // 코인 ID
    let name: String    // 코인 이름
    let symbol: String  // 코인 통화 단위
    let iconStr: String // 코인 아이콘 리소스
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case iconStr = "thumb"
    }
}
