//
//  SearchTableViewCell.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 2/28/24.
//

import UIKit
import SnapKit

class SearchTableViewCell: BaseTableViewCell {
    let iconImageView = UIImageView()
    let nameLabel = UILabel()
    let symbolLabel = UILabel()
    let favoriteButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.setCornerRadius(.circle(iconImageView))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        favoriteButton.isSelected = false
    }
    
    override func configureHierarchy() {
        contentView.addSubviews(iconImageView, nameLabel, symbolLabel, favoriteButton)
    }
    
    override func configureLayout() {
        iconImageView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.size.equalTo(40)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.top)
            make.leading.equalTo(iconImageView.snp.trailing).offset(12)
        }
        
        symbolLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(nameLabel)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.size.equalTo(50)
        }
    }
    
    override func configureView() {
        iconImageView.backgroundColor = .accentColor
        
        nameLabel.text = "Bitcoin"
        nameLabel.font = .sfBold18
        
        symbolLabel.text = "BTC"
        symbolLabel.font = .sfRegular16
        symbolLabel.textColor = .mediumGray
        
        favoriteButton.setImage(.btnStar, for: .normal)
        favoriteButton.setImage(.btnStarFill, for: .selected)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonClicked), for: .touchUpInside)
    }
    
    @objc func favoriteButtonClicked() {
        favoriteButton.isSelected.toggle()
    }
    
    override func bindData<T>(data: T) {
        
    }
}
