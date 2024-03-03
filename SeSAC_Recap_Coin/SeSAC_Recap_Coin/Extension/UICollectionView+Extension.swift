//
//  UICollectionView+Extension.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 3/3/24.
//

import UIKit

extension UICollectionView {
    // 컬렌션뷰 레이아웃 설정
    func setLayout(inset: CGFloat, spacing: CGFloat, insetFromSuperView: CGFloat = 0, ratio: CGFloat, colCount: CGFloat) {
        let layout = UICollectionViewFlowLayout()
        
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = (deviceWidth - ((colCount - 1) * spacing + 2 * inset + 2 * insetFromSuperView)) / colCount
        
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth * ratio)
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        self.collectionViewLayout = layout
    }
}
