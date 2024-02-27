//
//  Int+Extension.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 2/27/24.
//

import Foundation

extension Int {
    var divided255: CGFloat {
        return CGFloat(self) / 255
    }
    
    private static let numberFormatter = NumberFormatter()
    
    // 세자리 단위 콤마 표현
    func setComma() -> String {
        Int.numberFormatter.numberStyle = .decimal
        return Int.numberFormatter.string(for: self) ?? "0"
    }
}
