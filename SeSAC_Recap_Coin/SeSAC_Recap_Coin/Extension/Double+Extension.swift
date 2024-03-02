//
//  Double+Extension.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 2/29/24.
//

import Foundation

extension Double {
    var preprocessPriceChangePer: String {
        let sign = self > 0 ? "+": ""
        return sign + String(format: "%.2f", self) + "%"
    }
    
    var preprocessPrice: String {
        return "$" + "\(String(format: "%.3f", self))"
    }
}
