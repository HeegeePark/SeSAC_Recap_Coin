//
//  TrendingCollectionViewHeaderView.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 3/4/24.
//

import UIKit
import SnapKit

class TrendingCollectionViewHeaderView: UICollectionReusableView {
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.font = .sfBold18
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
    }
    
    func setTitle(title: String?) {
        titleLabel.text = title
    }
}
