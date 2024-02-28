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
}
