//
//  FavoriteViewModel.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 3/3/24.
//

import Foundation

final class FavoriteViewModel: ViewModelAvailable {
    let repository = FavoriteCoinsRepository()
    
    struct Input {
        let viewDidLoadEvent: Observable<Void?>
        let viewDidAppearEvent: Observable<Void?>
        let collectionViewCellDidSelectItemAtEvent: Observable<
        Int>
    }
    
    struct Output {
        let favoriteCoins: Observable<[CoinMarketData]> = Observable([])
        let coinIdForChart: Observable<String?> = Observable(nil)
    }
    
    func transform(from input: Input) -> Output {
        let output = Output()
        
        input.viewDidLoadEvent.bind { _ in
            self.fetchCoinInfo(output: output)
        }
        
        input.viewDidAppearEvent.bind { _ in
            self.fetchCoinInfo(output: output)
        }
        
        input.collectionViewCellDidSelectItemAtEvent.bind { item in self.coinInfo(at: item, output: output)
        }
        
        return output
    }
    
    private func fetchCoinInfo(output: Output) {
        let ids = fetchCoinIdFromRealm()
        
        APIService.shared.request(router: .coinMarket(ids: ids, sparkline: false), model: CoinMarketModel.self) { result in
            switch result {
            case .success(let model):
                output.favoriteCoins.value = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchCoinIdFromRealm() -> [String] {
        return Array(self.repository.fetch()).map { $0.coinId }
    }
    
    private func coinInfo(at index: Int, output: Output) {
        guard 0..<output.favoriteCoins.value.count ~= index else {
            return
        }
        
        output.coinIdForChart.value =  output.favoriteCoins.value[index].id
    }
}
