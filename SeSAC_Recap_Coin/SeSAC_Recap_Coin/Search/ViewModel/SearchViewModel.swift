//
//  SearchViewModel.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 2/28/24.
//

import Foundation

final class SearchViewModel: ViewModelAvailable {
    
    let repository = FavoriteCoinsRepository()
    
    struct Input {
        let viewDidLoadEvent: Observable<Void?>
        let viewDidAppearEvent: Observable<Void?>
        let searchControllerUpdateSearchResultsEvent: Observable<String?>
        let tableViewCellDidSelectRowAtEvent: Observable<
        Int>
        let tableViewCellFavoriteButtonClickedEvent: Observable<(isSelected: Bool, at: Int)?>
    }
    
    struct Output {
        let searchResult: Observable<[SearchCoin]> = Observable([])
        let favoriteCoins: Observable<[FavoriteCoins]> = Observable([])
        let coinIdForChart: Observable<String?> = Observable(nil)
        let tableViewCellFavoriteButtonClickedEvent: Observable<Void?> = Observable(nil)
        let completedUpdateFavorites: Observable<String> = Observable("")
    }
    
    func transform(from input: Input) -> Output {
        let output = Output()
        
        input.viewDidLoadEvent.bind { _ in
            self.fetchFromRealm(output: output)
        }
        
        input.viewDidAppearEvent.bind { _ in
            self.fetchFromRealm(output: output)
        }
        
        input.searchControllerUpdateSearchResultsEvent.bind { text in
            self.fetchSearchResult(text: text, output: output)
        }
        
        input.tableViewCellDidSelectRowAtEvent.bind { row in self.coinInfo(at: row, output: output)
        }
        
        input.tableViewCellFavoriteButtonClickedEvent.bind { cell  in
            guard let cell else { return }
            self.updateFavoriteCoins(output: output, cell: cell)
        }
        
        return output
    }
    
    private func fetchSearchResult(text: String?, output: Output) {
        guard let keyword = validateString(text: text) else {
            output.searchResult.value = []
            return
        }
        
        APIService.shared.request(router: .search(query: keyword), model: SearchModel.self) { [output] result in
            switch result {
            case .success(let response):
                output.searchResult.value = response.coins
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func validateString(text: String?) -> String? {
        guard let text, !text.isEmpty else {
            return nil
        }
        
        guard !text.removeWhitespaces.isEmpty else {
            return nil
        }
        
        return text.refineForSearch
    }
    
    private func coinInfo(at index: Int, output: Output) {
        guard 0..<output.searchResult.value.count ~= index else {
            return
        }
        
        output.coinIdForChart.value =  output.searchResult.value[index].id
    }
    
    private func fetchFromRealm(output: Output) {
        let favorites = Array(self.repository.fetch())
        output.favoriteCoins.value = favorites
    }
    
    private func updateFavoriteCoins(output: Output, cell: (isSelected: Bool, at: Int)) {
        let coinId = output.searchResult.value[cell.at].id
        if cell.isSelected {
            let favoriteCoin = FavoriteCoins(coinId: coinId)
            if output.favoriteCoins.value.count < 10 {
                self.repository.createItem(favoriteCoin)
                output.completedUpdateFavorites.value = "즐겨찾기에 추가되었습니다. 🤑"
            } else {
                output.completedUpdateFavorites.value = "즐겨찾기는 최대 10개까지 가능합니다."
            }
        } else {
            let favoriteCoin = self.repository.fetchFiltered(results: self.repository.fetch(), key: "coinId", value: coinId).first!
            self.repository.deleteItem(object: favoriteCoin)
            output.completedUpdateFavorites.value = "즐겨찾기에서 삭제되었습니다. ☹️"
        }
        fetchFromRealm(output: output)
    }
}
