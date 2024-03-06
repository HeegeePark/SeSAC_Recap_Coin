//
//  TrendingTopCollectionViewCell.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 3/4/24.
//

import UIKit
import SnapKit

import UIKit
import SnapKit

class TrendingTopCollectionViewCell: BaseCollectionViewCell {
    private let rankLabel = UILabel()
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
    
    func bindData(data: RankInfo) {
        if data.symbol == "BICO" {
            print(data.currentPrice)
            print(data.priceChangePer24h)
        }
        rankLabel.text = "\(data.rank)"
        iconImageView.loadImage(source: data.iconStr)
        nameLabel.text = data.name
        symbolLabel.text = data.symbol
        currentPriceLabel.text = data.currentPrice
        priceChangePerLabel.textColor = data.isIncresedPriceChangePer ? .grapefruit: .lightBlue
        priceChangePerLabel.text = data.priceChangePer24h
    }
    
    override func configureHierarchy() {
        contentView.addSubviews(rankLabel, iconImageView, nameLabel, symbolLabel, currentPriceLabel, priceChangePerLabel)
    }
    
    override func configureLayout() {
        rankLabel.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
            make.size.equalTo(30)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalTo(rankLabel)
            make.leading.equalTo(rankLabel.snp.trailing)
            make.size.equalTo(35)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView)
            make.leading.equalTo(iconImageView.snp.trailing).offset(8)
            make.trailing.greaterThanOrEqualTo(currentPriceLabel.snp.leading).offset(-12)
        }
        
        symbolLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.trailing.greaterThanOrEqualTo(priceChangePerLabel.snp.leading).offset(-12)
            make.bottom.equalTo(iconImageView)
        }
        
        currentPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(8)
        }
        
        priceChangePerLabel.snp.makeConstraints { make in
            make.top.equalTo(symbolLabel)
            make.trailing.equalTo(currentPriceLabel)
        }
    }
    
    override func configureView() {
        contentView.backgroundColor = .white
        rankLabel.font = .sfBold24
        rankLabel.textColor = .mediumGray
        nameLabel.font = .sfBold14
        symbolLabel.font = .sfRegular14
        symbolLabel.textColor = .mediumGray
        currentPriceLabel.font = .sfBold16
        priceChangePerLabel.font = .sfRegular14
        priceChangePerLabel.textAlignment = .center
        priceChangePerLabel.textColor = .grapefruit
        priceChangePerLabel.setCornerRadius(.custom(4))
    }
}
