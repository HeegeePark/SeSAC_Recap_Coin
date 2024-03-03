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
        let favoriteCoins: Observable<[FavoriteCoins]> = Observable([])
        let coinIdForChart: Observable<String?> = Observable(nil)
    }
    
    func transform(from input: Input) -> Output {
        let output = Output()
        
        return output
    }
}
