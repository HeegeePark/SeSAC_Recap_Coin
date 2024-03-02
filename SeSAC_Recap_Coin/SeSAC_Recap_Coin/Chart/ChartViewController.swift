//
//  ChartViewController.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 2/28/24.
//

import UIKit
import SnapKit

final class ChartViewController: BaseViewController {
    
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let currentPriceLabel = UILabel()
    private let priceChangePer24hLabel = UILabel()
    private let high24hLabel = UILabel()
    private let low24hLabel = UILabel()
    private let athLabel = UILabel()
    private let atlLabel = UILabel()
    private let lastUpdatedLabel = UILabel()
    
    // fixed
    private let todayLabel = {
        let lb = UILabel()
        lb.text = "Today"
        return lb
    }()
    private let descriptionHigh24hLabel = {
        let lb = UILabel()
        lb.text = "고가"
        return lb
    }()
    private let descriptionLow24hLabel = {
        let lb = UILabel()
        lb.text = "저가"
        return lb
    }()
    private let descriptionAthLabel = {
        let lb = UILabel()
        lb.text = "신고점"
        return lb
    }()
    private let descriptionAtlLabel = {
        let lb = UILabel()
        lb.text = "신저점"
        return lb
    }()
    
    private let viewModel = ChartViewModel()
    private var input: ChartViewModel.Input!
    private var output: ChartViewModel.Output!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func bindViewModel(id: String) {
        input = ChartViewModel.Input(bindViewModelEvent: Observable(id))
        output = viewModel.transform(from: input)
        
        output.chartInfo.bind { [self] data in
            guard let data else { return }
            iconImageView.loadImage(source: data.info.iconStr)
            titleLabel.text = data.info.name
            currentPriceLabel.text = data.info.currentPrice
            priceChangePer24hLabel.text = data.info.priceChangePer24h
            high24hLabel.text = data.info.high24h
            low24hLabel.text = data.info.low24h
            athLabel.text = data.info.ath
            atlLabel.text = data.info.atl
            lastUpdatedLabel.text = data.info.lastUpdated
            
        }
    }
    
    override func configureHierarchy() {
        view.addSubviews(iconImageView, titleLabel,
                         currentPriceLabel, priceChangePer24hLabel, todayLabel,
                         descriptionHigh24hLabel, high24hLabel,
                         descriptionLow24hLabel, low24hLabel,
                         descriptionAthLabel, athLabel,
                         descriptionAtlLabel, atlLabel,
                         lastUpdatedLabel
        )
    }
    
    override func configureLayout() {
        let inset: CGFloat = 12
        let priceWidth: CGFloat = (UIScreen.main.bounds.width - 3 * inset) / 2
        iconImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(inset)
            make.size.equalTo(45)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView)
            make.leading.equalTo(iconImageView.snp.trailing).offset(8)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(inset)
        }
        
        currentPriceLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView)
            make.trailing.equalTo(titleLabel)
            make.top.equalTo(iconImageView.snp.bottom).offset(inset)
        }
        
        priceChangePer24hLabel.snp.makeConstraints { make in
            make.leading.equalTo(currentPriceLabel)
            make.top.equalTo(currentPriceLabel.snp.bottom).offset(8)
        }
        
        todayLabel.snp.makeConstraints { make in
            make.leading.equalTo(priceChangePer24hLabel.snp.trailing).offset(8)
            make.top.equalTo(priceChangePer24hLabel)
        }
        
        descriptionHigh24hLabel.snp.makeConstraints { make in
            make.leading.equalTo(priceChangePer24hLabel)
            make.top.equalTo(priceChangePer24hLabel.snp.bottom).offset(28)
            make.width.equalTo(priceWidth)
            
        }
        
        high24hLabel.snp.makeConstraints { make in
            make.leading.equalTo(descriptionHigh24hLabel)
            make.top.equalTo(descriptionHigh24hLabel.snp.bottom).offset(8)
            make.width.equalTo(priceWidth)
        }
        
        descriptionLow24hLabel.snp.makeConstraints { make in
            make.leading.equalTo(descriptionHigh24hLabel.snp.trailing).offset(inset)
            make.top.equalTo(descriptionHigh24hLabel)
            make.width.equalTo(priceWidth)
        }
        
        low24hLabel.snp.makeConstraints { make in
            make.leading.equalTo(descriptionLow24hLabel)
            make.top.equalTo(descriptionLow24hLabel.snp.bottom).offset(8)
            make.width.equalTo(priceWidth)
        }
        
        descriptionAthLabel.snp.makeConstraints { make in
            make.leading.equalTo(high24hLabel)
            make.top.equalTo(high24hLabel.snp.bottom).offset(16)
            make.width.equalTo(priceWidth)
            
        }
        
        athLabel.snp.makeConstraints { make in
            make.leading.equalTo(descriptionAthLabel)
            make.top.equalTo(descriptionAthLabel.snp.bottom).offset(8)
            make.width.equalTo(priceWidth)
        }
        
        descriptionAtlLabel.snp.makeConstraints { make in
            make.leading.equalTo(descriptionLow24hLabel)
            make.top.equalTo(descriptionAthLabel)
            make.width.equalTo(priceWidth)
        }
        
        atlLabel.snp.makeConstraints { make in
            make.leading.equalTo(descriptionAtlLabel)
            make.top.equalTo(descriptionAtlLabel.snp.bottom).offset(8)
            make.width.equalTo(priceWidth)
        }
        
        lastUpdatedLabel.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(inset)
        }
    }
    
    override func configureView() {
        iconImageView.setCornerRadius(.circle(iconImageView))
        titleLabel.font = .title
        currentPriceLabel.font = .title
        priceChangePer24hLabel.textColor = .grapefruit
        priceChangePer24hLabel.font = .sfBold16
        todayLabel.textColor = .mediumGray
        todayLabel.font = .sfBold16
        [descriptionHigh24hLabel, descriptionAthLabel].forEach {
            $0.textColor = .grapefruit
            $0.font = .sfBold18
        }
        [descriptionLow24hLabel, descriptionAtlLabel].forEach {
            $0.textColor = .customBlue
            $0.font = .sfBold18
        }
        
        [high24hLabel, low24hLabel, athLabel, atlLabel].forEach {
            $0.textColor = .mediumGray
            $0.font = .sfBold16
        }
        lastUpdatedLabel.textColor = .black
        lastUpdatedLabel.font = .sfRegular14
        lastUpdatedLabel.textAlignment = .right
    }
    
    override func configureNavigationBar() {
        
    }
}
