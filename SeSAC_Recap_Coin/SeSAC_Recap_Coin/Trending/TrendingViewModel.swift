//
//  TrendingViewModel.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 3/4/24.
//

import Foundation

final class TrendingViewModel: ViewModelAvailable {
    let repository = FavoriteCoinsRepository()
    
    struct Input {
        let viewDidLoadEvent: Observable<Void?>
        let viewDidAppearEvent: Observable<Void?>
        let collectionViewCellDidSelectItemAtEvent: Observable<
        Int>
    }
    
    struct Output {
        let favoriteCoins: Observable<[CoinMarketData]> = Observable([])
        let topCoins: Observable<[RankInfo]> = Observable([])
        let topNFTs: Observable<[RankInfo]> = Observable([])
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
        let favoriteIds = fetchCoinIdFromRealm()
        
        // favorite
        APIService.shared.request(router: .coinMarket(ids: favoriteIds, sparkline: false), model: CoinMarketModel.self) { result in
            switch result {
            case .success(let model):
                output.favoriteCoins.value = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        // trending
        APIService.shared.request(router: .trending, model: TrendingModel.self) { result in
            switch result {
            case .success(let model):
                output.topCoins.value = self.asRankInfo(data: model.coins)
                output.topNFTs.value = self.asRankInfoType(data: model.nfts)
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
    
    private func asRankInfo(data: [TrendingCoin]) -> [RankInfo] {
        let info = data.enumerated().map { (i, coin) in
            let rankInfo = RankInfo(
                id: coin.item.id,
                rank: i + 1,
                name: coin.item.name,
                symbol: coin.item.symbol,
                iconStr: coin.item.iconStr,
                currentPrice: coin.item.data.price,
                isIncresedPriceChangePer: coin.item.data.priceChangePer24h.krw > 0,
                priceChangePer24h: coin.item.data.priceChangePer24h.krw.preprocessPriceChangePer
            )
            return rankInfo
        }
        return info
    }
    
    private func asRankInfoType(data: [NFT]) -> [RankInfo] {
        return data.enumerated().map { (i, nft) in
            let rankInfo = RankInfo(
                id: nil,
                rank: i + 1,
                name: nft.name,
                symbol: nft.symbol,
                iconStr: nft.iconStr,
                currentPrice: nft.data.lowPrice,
                isIncresedPriceChangePer: nft.data.lowPriceChangePer24h.first! != "-",
                priceChangePer24h: Double(nft.data.lowPriceChangePer24h)!.preprocessPriceChangePer
            )
            return rankInfo
        }
    }
}
