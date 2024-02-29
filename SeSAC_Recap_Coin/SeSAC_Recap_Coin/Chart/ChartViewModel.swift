//
//  ChartViewModel.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 2/29/24.
//

import Foundation

final class ChartViewModel {
    // TODO: (viewdidLoad id) -> { market api fetch, numberformat, 168개의 prices -> 4시간씩 평균값 168/4개의 prices 변환, 즐겨찾기 realm filter } -> tuple(model(name, iconStr, currentPrice(n), low24h(n), high24h(n), ath(n), atl(n), lastUpdated), SparklineIn7dPrices(transform), isFavorite)
    
    struct Input {
        let coinId: Observable<String>
    }
    
    struct Output {
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.coinId.bind { id in
            print(id)
        }
        
        return output
    }
}
