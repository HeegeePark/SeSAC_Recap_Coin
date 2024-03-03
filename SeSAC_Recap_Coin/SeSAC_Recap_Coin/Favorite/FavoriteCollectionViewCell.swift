//
//  FavoriteCollectionViewCell.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 3/3/24.
//

import UIKit
import SnapKit

final class FavoriteCollectionViewCell: BaseCollectionViewCell {
    private let iconImageView = UIImageView()
    private let nameLabel = UILabel()
    private let symbolLabel = UILabel()
    
    private let currentPriceLabel = UILabel()
    private let priceChangePerLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubviews(iconImageView, nameLabel, symbolLabel,
                                currentPriceLabel, priceChangePerLabel)
    }
    
    override func configureLayout() {
        iconImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView.safeAreaLayoutGuide).inset(12)
            make.size.equalTo(35)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView)
            make.leading.equalTo(iconImageView.snp.trailing).offset(12)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(12)
        }
        
        symbolLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(nameLabel)
            make.bottom.equalTo(iconImageView)
        }
        
        priceChangePerLabel.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(12)
        }
        
        currentPriceLabel.snp.makeConstraints { make in
            make.trailing.equalTo(priceChangePerLabel)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(12).priority(.low)
            make.bottom.equalTo(priceChangePerLabel.snp.top).offset(-4)
        }
    }
    
    override func configureView() {
        contentView.backgroundColor = .white
        contentView.setCornerRadius()
        contentView.setShadow(color: .mediumGray)
        nameLabel.font = .sfBold18
        symbolLabel.font = .sfRegular14
        symbolLabel.textColor = .mediumGray
        currentPriceLabel.font = .sfBold16
        priceChangePerLabel.font = .sfBold14
        priceChangePerLabel.textColor = .grapefruit
        priceChangePerLabel.backgroundColor = .lightPink
        priceChangePerLabel.setCornerRadius()
        
        // dummy
        iconImageView.backgroundColor = .accentColor
        nameLabel.text = "bitcoin"
        symbolLabel.text = "BTc"
        currentPriceLabel.text = 692342355.preprocessPrice
        priceChangePerLabel.text = 0.64.preprocessPriceChangePer
    }
    
}
