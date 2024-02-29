//
//  ViewModelAvailable.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 2/29/24.
//

import Foundation

protocol ViewModelAvailable {
    associatedtype Input
    associatedtype Output
    func transform(from input: Input) -> Output
}
