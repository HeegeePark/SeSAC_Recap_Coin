//
//  UIImageView+Extension.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 2/28/24.
//

import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(source: String) {
        guard let url = URL(string: source) else { return }
        self.kf.setImage(with: url)
    }
}

