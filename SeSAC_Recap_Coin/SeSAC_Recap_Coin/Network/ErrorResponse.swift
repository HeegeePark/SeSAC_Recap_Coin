//
//  ErrorResponse.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 3/2/24.
//

import Foundation

struct ErrorResponse: Decodable {
    let status: Status
}

struct Status: Decodable {
    let error_code: Int
    let error_message: String
}
