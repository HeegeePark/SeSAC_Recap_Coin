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
    
    // fixed
    private let todayLabel = UILabel()
    private let descriptionHigh24hLabel = UILabel()
    private let descriptionLow24hLabel = UILabel()
    private let descriptionAthLabel = UILabel()
    private let descriptionAtlLabel = UILabel()
    
    private let viewModel = ChartViewModel()
    private var input: ChartViewModel.Input!
    private var output: ChartViewModel.Output!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func bindViewModel(id: String) {
        input = ChartViewModel.Input(bindViewModelEvent: Observable(id))
        output = viewModel.transform(from: input)
        
        output.chartInfo.bind { info in
            print(info)
        }
    }
}
