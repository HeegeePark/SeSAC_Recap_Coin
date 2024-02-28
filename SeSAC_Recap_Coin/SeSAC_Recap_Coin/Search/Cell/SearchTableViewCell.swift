//
//  SearchTableViewCell.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 2/28/24.
//

import UIKit
import SnapKit

final class SearchTableViewCell: BaseTableViewCell {
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
    
    func bindData(data: SearchCoin) {
        iconImageView.loadImage(source: data.iconStr)
        nameLabel.text = data.name
        symbolLabel.text = data.symbol
        // TODO: realm 결과로부터 즐겨찾기 버튼 상태 바인딩
    }
    
    @objc func favoriteButtonClicked() {
        favoriteButton.isSelected.toggle()
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
            make.top.equalToSuperview().inset(4)
            make.leading.equalTo(iconImageView.snp.trailing).offset(12)
            make.trailing.equalTo(favoriteButton.snp.leading).inset(12)
        }
        
        symbolLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.bottom.equalToSuperview().inset(4)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.size.equalTo(50)
        }
    }
    
    override func configureView() {
        iconImageView.backgroundColor = .accentColor
        nameLabel.font = .sfBold18
        symbolLabel.font = .sfRegular16
        symbolLabel.textColor = .mediumGray
        favoriteButton.setImage(.btnStar, for: .normal)
        favoriteButton.setImage(.btnStarFill, for: .selected)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonClicked), for: .touchUpInside)
    }
}
