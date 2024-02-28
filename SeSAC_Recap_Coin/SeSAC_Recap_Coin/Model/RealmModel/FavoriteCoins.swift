//
//  FavoriteCoins.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 2/28/24.
//

import Foundation
import RealmSwift

class FavoriteCoins: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var coinId: String   // 코인 아이디
    
    convenience init(coinId: String) {
        self.init()
        self.coinId = coinId
    }
}
