//
//  ChartViewController.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 2/28/24.
//

import UIKit

final class ChartViewController: BaseViewController {
    
    let viewModel = ChartViewModel()
    var input: ChartViewModel.Input!
    var output: ChartViewModel.Output!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func bindViewModel(id: String) {
        input = ChartViewModel.Input(coinId: Observable(id))
        output = viewModel.transform(input: input)
        // TODO: output bind
    } 
}
