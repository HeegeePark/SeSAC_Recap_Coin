//
//  String+Extension.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 2/28/24.
//

import Foundation

extension String {
    var removeWhitespaces: String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    var refineForSearch: String {
        return self.removeWhitespaces
            .trimmingCharacters(in: .whitespaces)
    }
    
    var preprocessUpdatedDate: String {
        guard let date = DateManager.shared.toDate(string: self) else { 
            return "업데이트 일자를 불러올 수 없음"
        }
        return DateManager.shared.toString(date: date,
                                           format: "M/d일 HH:mm:ss 업데이트")
    }
}
