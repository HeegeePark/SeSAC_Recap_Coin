//
//  UIView+Extension.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 2/28/24.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        for subview in subviews {
            self.addSubview(subview)
        }
    }
    
    func setCornerRadius(_ style: CornerRoundStyle = .default) {
        self.layer.cornerRadius = style.cornerRadius
        self.layer.masksToBounds = true
    }
    
    func setShadow(color: UIColor = .black, opacity: Float = 0.1, radius: CGFloat = 3) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
    }
}

enum CornerRoundStyle {
    case `default`
    case small
    case medium
    case large
    case circle(UIView)
    
    var cornerRadius: CGFloat {
        switch self {
        case .default:
            return 10
        case .small:
            return 8
        case .medium:
            return 16
        case .large:
            return 20
        case .circle(let view):
            return view.frame.width / 2
        }
    }
}
