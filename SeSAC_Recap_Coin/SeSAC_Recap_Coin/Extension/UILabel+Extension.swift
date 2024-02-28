//
//  UILabel+Extension.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 2/28/24.
//

import UIKit

extension UILabel {
    func changeForegroundColor(keyword: String, color: UIColor) {
        guard let text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        
        let range = (text as NSString).range(of: keyword)
        
        attributedString.addAttribute(.foregroundColor, value: color,
                                      range: range)
        
        self.attributedText = attributedString
    }
}
