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
    
    func bindData(data: CoinMarketData) {
        iconImageView.loadImage(source: data.iconStr)
        nameLabel.text = data.name
        symbolLabel.text = data.symbol
        currentPriceLabel.text = data.currentPrice.preprocessPrice
        configurePriceChangePerLabel(value: data.priceChangePer24h)
    }
    
    private func configurePriceChangePerLabel(value: Double) {
        if value > 0 {
            priceChangePerLabel.textColor = .grapefruit
            priceChangePerLabel.backgroundColor = .lightPink
        } else {
            priceChangePerLabel.textColor = .customBlue
            priceChangePerLabel.backgroundColor = .lightBlue
        }
        priceChangePerLabel.text = value.preprocessPriceChangePer
        updatePriceChangePerLabelLayout()
    }
    
    private func updatePriceChangePerLabelLayout() {
        let size = priceChangePerLabel.sizeThatFits(contentView.frame.size)
        priceChangePerLabel.frame.size = size
        priceChangePerLabel.snp.remakeConstraints { make in
            let horizontalInset: CGFloat = 8
            let verticalInset: CGFloat = 4
            make.width.equalTo(horizontalInset * 2 + size.width)
            make.height.equalTo(verticalInset * 2 + size.height)
            make.bottom.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(12)
        }
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
            make.leading.equalTo(iconImageView.snp.trailing).offset(8)
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
        contentView.setShadow()
        nameLabel.font = .sfBold14
        symbolLabel.font = .sfRegular14
        symbolLabel.textColor = .mediumGray
        currentPriceLabel.font = .sfBold16
        priceChangePerLabel.font = .sfSemiBold12
        priceChangePerLabel.textAlignment = .center
        priceChangePerLabel.textColor = .grapefruit
        priceChangePerLabel.backgroundColor = .lightPink
        priceChangePerLabel.setCornerRadius(.custom(4))
    }
    
}
