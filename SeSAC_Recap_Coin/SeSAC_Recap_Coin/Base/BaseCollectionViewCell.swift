//
//  BaseCollectionViewCell.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 3/3/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
    }
    
    func configureLayout() {
    }
    
    func configureView() {
    }
}
