//
//  FavoriteButton.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 2/29/24.
//

import UIKit

protocol Favoritable: AnyObject {
    func favoriteButtonTapped(isSelected: Bool)
}

class FavoriteButton: UIButton {
    weak var delegate: Favoritable?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func clicked() {
        isSelected.toggle()
        delegate?.favoriteButtonTapped(isSelected: isSelected)
    }
    
    private func configureView() {
        setImage(.btnStar, for: .normal)
        setImage(.btnStarFill, for: .selected)
        addTarget(self, action: #selector(clicked), for: .touchUpInside)
    }
}
