//
//  TrendingFavoriteCollectionViewCell.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 3/4/24.
//

import UIKit
import SnapKit

final class TrendingFavoriteCollectionViewCell: BaseCollectionViewCell {
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
        priceChangePerLabel.textColor = value >= 0 ? .grapefruit: .lightBlue
        priceChangePerLabel.text = value.preprocessPriceChangePer
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
            make.leading.equalTo(iconImageView)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(12)
        }
        
        currentPriceLabel.snp.makeConstraints { make in
            make.leading.equalTo(priceChangePerLabel)
            make.trailing.equalTo(nameLabel)
            make.bottom.equalTo(priceChangePerLabel.snp.top).offset(-4)
        }
    }
    
    override func configureView() {
        contentView.backgroundColor = .customLightGray
        contentView.setCornerRadius()
        nameLabel.font = .sfBold14
        symbolLabel.font = .sfRegular14
        symbolLabel.textColor = .mediumGray
        currentPriceLabel.font = .sfBold16
        priceChangePerLabel.font = .sfSemiBold12
        priceChangePerLabel.textAlignment = .center
        priceChangePerLabel.textColor = .grapefruit
        priceChangePerLabel.setCornerRadius(.custom(4))
    }
}
