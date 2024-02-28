//
//  SearchViewModel.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 2/28/24.
//

import Foundation

final class SearchViewModel {
    // TODO: 테이블뷰 즐겨찾기 버튼 클릭 -> (realm update) -> reload tableview
    
    struct Input {
        let searchControllerUpdateSearchResultsEvent: Observable<String?>
        let tablewViewCellDidSelectRowAtEvent: Observable<
        Int>
//        let tableViewCellFavoriteButtonClickedEvent: Observable<Int>
    }
    
    struct Output {
        let searchResult: Observable<[SearchCoin]> = Observable([])
        let coinInfoForChart: Observable<SearchCoin?> = Observable(nil)
    }
    
    func transform(from input: Input) -> Output {
        let output = Output()
        
        input.searchControllerUpdateSearchResultsEvent.bind { text in
            self.fetchSearchResult(text: text, output: output)
        }
        
        input.tablewViewCellDidSelectRowAtEvent.bind { row in self.coinInfo(at: row, output: output)
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
        
        output.coinInfoForChart.value =  output.searchResult.value[index]
    }
}
