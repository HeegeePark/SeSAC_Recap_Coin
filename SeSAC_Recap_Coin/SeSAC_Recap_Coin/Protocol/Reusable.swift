//
//  Reusable.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 2/28/24.
//

import UIKit

protocol Reusable: NSObject {
    static var identifier: String { get }
}

extension Reusable {
    static var identifier: String {
        return description()
    }
}

extension UIView: Reusable {}
