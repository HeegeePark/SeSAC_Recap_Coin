//
//  ChartViewController.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 2/28/24.
//

import UIKit
import SnapKit
import DGCharts

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
    private let lineChartView = LineChartView()
    private let favoriteButton = FavoriteButton()
    
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        iconImageView.setCornerRadius(.circle(iconImageView))
    }
    
    func bindViewModel(id: String) {
        input = ChartViewModel.Input(
            bindViewModelEvent: Observable(id),
            favoriteButtonTappedEvent: Observable(false)
        )
        output = viewModel.transform(from: input)
        
        output.chartInfo.bind { [self] data in
            guard let data else { return }
            iconImageView.loadImage(source: data.info.iconStr)
            titleLabel.text = data.info.name
            currentPriceLabel.text = data.info.currentPrice
            updatePriceChangePer24hLabel(isIncreased: data.info.isIncresedPriceChangePer)
            priceChangePer24hLabel.text = data.info.priceChangePer24h
            high24hLabel.text = data.info.high24h
            low24hLabel.text = data.info.low24h
            athLabel.text = data.info.ath
            atlLabel.text = data.info.atl
            lastUpdatedLabel.text = data.info.lastUpdated
            drawLineChartView(sparkline: data.sparklineIn7dPrices)
            favoriteButton.isSelected = data.isFavorite
        }
        
        output.completedUpdateFavorites.bind { completedMessage in
            guard !completedMessage.isEmpty else { return }
            self.showToast(completedMessage)
        }
        
        output.errorOccuredUpdateFavorites.bind { errorMessage in
            guard let errorMessage else { return }
            self.favoriteButton.isSelected.toggle()
            self.showToast(errorMessage)
        }
    }
    
    private func updatePriceChangePer24hLabel(isIncreased: Bool) {
        priceChangePer24hLabel.textColor = isIncreased ? .grapefruit: .customBlue
    }
    
    private func drawLineChartView(sparkline: [Double]) {
        let lineChartEntry: [ChartDataEntry] = sparkline.enumerated().map { (i, value) in
            ChartDataEntry(x: Double(i), y: value)
        }
        let dataSet = LineChartDataSet(entries: lineChartEntry)
        dataSet.setColor(.accentColor)
        dataSet.drawValuesEnabled = false
        dataSet.drawCirclesEnabled = false
        
        // fill color
        let gradientColors = [UIColor.white.cgColor,
                              UIColor.accentColor.cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        dataSet.fillAlpha = 1
        dataSet.fill = LinearGradientFill(gradient: gradient, angle: 90)
        dataSet.drawFilledEnabled = true
        
        // 라인 두께
        dataSet.lineWidth = 2
        
        // 그래프 꺾임 모드?
        dataSet.mode = .cubicBezier
        
        // indicator 제거
        dataSet.drawVerticalHighlightIndicatorEnabled = false
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        
        let data = LineChartData(dataSet: dataSet)
        data.isHighlightEnabled = true
        lineChartView.data = data
    }
    
    override func configureHierarchy() {
        view.addSubviews(iconImageView, titleLabel,
                         currentPriceLabel, priceChangePer24hLabel, todayLabel,
                         descriptionHigh24hLabel, high24hLabel,
                         descriptionLow24hLabel, low24hLabel,
                         descriptionAthLabel, athLabel,
                         descriptionAtlLabel, atlLabel,
                         lineChartView,
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
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(inset)
            make.top.equalTo(descriptionHigh24hLabel)
            make.width.equalTo(priceWidth)
        }
        
        low24hLabel.snp.makeConstraints { make in
            make.leading.equalTo(descriptionLow24hLabel)
            make.trailing.equalTo(descriptionLow24hLabel)
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
            make.trailing.equalTo(low24hLabel)
            make.top.equalTo(descriptionAthLabel)
            make.width.equalTo(priceWidth)
        }
        
        atlLabel.snp.makeConstraints { make in
            make.leading.equalTo(descriptionAtlLabel)
            make.trailing.equalTo(descriptionAtlLabel)
            make.top.equalTo(descriptionAtlLabel.snp.bottom).offset(8)
            make.width.equalTo(priceWidth)
        }
        
        lineChartView.snp.makeConstraints { make in
            make.top.equalTo(atlLabel.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(lastUpdatedLabel.snp.top)
        }
        
        lastUpdatedLabel.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(inset)
        }
    }
    
    override func configureView() {
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
        configureLineChartView()
    }
    
    private func configureLineChartView() {
        // grid 없애기
        lineChartView.xAxis.enabled = false
        lineChartView.leftAxis.enabled = false
        lineChartView.rightAxis.enabled = false
        
        // x축 애니메이션
        lineChartView.animate(xAxisDuration: 2)
        
        // label 제거
        lineChartView.legend.enabled = false
        
        // 마커
        let marker = CircleMarker(color: .accentColor)
        lineChartView.marker = marker
    }
    
    override func configureNavigationBar() {
        super.configureNavigationBar()
        navigationController?.navigationBar.prefersLargeTitles = false
        favoriteButton.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favoriteButton)
    }
}

// MARK: - FavoriteButton Delegate

extension ChartViewController: Favoritable {
    func favoriteButtonTapped(isSelected: Bool) {
        input.favoriteButtonTappedEvent.value = isSelected
    }
}
