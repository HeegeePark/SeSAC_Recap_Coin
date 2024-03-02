//
//  ChartViewModel.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 2/29/24.
//

import Foundation

final class ChartViewModel: ViewModelAvailable {
    // TODO: 즐찾 기능(검색 화면 참고)
    
    let repository = FavoriteCoinsRepository()
    
    struct Input {
        let bindViewModelEvent: Observable<String>
        let favoriteButtonTappedEvent: Observable<Bool>
    }
    
    struct Output {
        typealias ChartInfoType = (
            info: (id: String,
                   name: String,
                   iconStr: String,
                   currentPrice: String,
                   priceChangePer24h: String,
                   low24h: String,
                   high24h: String,
                   ath: String,
                   atl: String,
                   lastUpdated: String
                  ),
            sparklineIn7dPrices: [Double],
            isFavorite: Bool
        )
        let chartInfo: Observable<ChartInfoType?> = Observable(nil)
        let completedUpdateFavorites: Observable<String> = Observable("")
        let errorOccuredUpdateFavorites: Observable<String?> = Observable(nil)
    }
    
    func transform(from input: Input) -> Output {
        let output = Output()
        
        input.bindViewModelEvent.bind { id in
            self.fetchCoinInfo(id: id, output: output)
        }
        
        input.favoriteButtonTappedEvent.bind { isSelected in
            do {
                output.completedUpdateFavorites.value = try self.updateFavorite(isSelected: isSelected, output: output)
            } catch {
                let error = error as! UpdatingFavoriteError
                output.errorOccuredUpdateFavorites.value = error.message
            }
        }
        
        return output
    }
    
    private func fetchCoinInfo(id: String, output: Output) {
        APIService.shared.request(router: .coinMarket(ids: [id], sparkline: true), model: CoinMarketModel.self) { [output] result in
            switch result {
            case .success(let response):
                guard let data = response.first else {
                    print("empty")
                    return
                }
                
                let chartInfo: Output.ChartInfoType = (
                    info: (id: data.id,
                           name: data.name,
                           iconStr: data.iconStr,
                           currentPrice: data.currentPrice.preprocessPrice,
                           priceChangePer24h: data.priceChangePer24h.preprocessPriceChangePer,
                           low24h: data.low24h.preprocessPrice,
                           high24h: data.high24h.preprocessPrice,
                           ath: data.ath.preprocessPrice,
                           atl: data.atl.preprocessPrice,
                           lastUpdated: data.lastUpdated.preprocessUpdatedDate
                          ),
                    sparklineIn7dPrices: self.compressByAverage(sparkline: data.sparklineIn7d!.price, chunkSize: 4),
                    isFavorite: self.fetchIsFavorite(coinId: data.id)
                )
                
                output.chartInfo.value = chartInfo
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func compressByAverage(sparkline: [Double], chunkSize: Int) -> [Double] {
        var compressed = [Double]()
        
        for i in stride(from: 0, to: sparkline.count, by: chunkSize) {
            let end = min(i + chunkSize, sparkline.count)
            let avg = sparkline[i..<end].reduce(0, +) / Double(chunkSize)
            compressed.append(avg)
        }
        
        return compressed
    }
    
    private func fetchIsFavorite(coinId: String) -> Bool {
        return repository.fetchFiltered(
            results: repository.fetch(),
                                 key: "coinId",
                                 value: coinId
        ).first != nil
    }
    
    private func updateFavorite(isSelected: Bool, output: Output) throws -> String {
        guard let coinId = output.chartInfo.value?.info.id else {
            return ""
        }
        if isSelected {
            let favoriteCoin = FavoriteCoins(coinId: coinId)
            if repository.fetch().count < 10 {
                self.repository.createItem(favoriteCoin)
                return "즐겨찾기에 추가되었습니다. 🤑"
            } else {
                throw UpdatingFavoriteError.max10
            }
        } else {
            let favoriteCoin = self.repository.fetchFiltered(results: self.repository.fetch(), key: "coinId", value: coinId).first!
            self.repository.deleteItem(object: favoriteCoin)
            return "즐겨찾기에서 삭제되었습니다. ☹️"
        }
    }
}

enum UpdatingFavoriteError: Error {
    case max10
    
    var message: String {
        switch self {
        case .max10:
            return "즐겨찾기는 최대 10개까지 가능합니다."
        }
    }
}
