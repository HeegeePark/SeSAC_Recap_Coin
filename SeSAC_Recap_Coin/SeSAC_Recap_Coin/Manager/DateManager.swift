//
//  DateManager.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 3/1/24.
//

import Foundation

final class DateManager {
    static let shared = DateManager()
    
    private init() { }
    
    private let formatToDate = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    
    private lazy var dateFormatter: DateFormatter = {
        let format = DateFormatter()
        format.dateFormat = formatToDate
        format.timeZone = TimeZone(identifier: "Asia/Seoul")
        return format
    }()
    
    func toString(date: Date, format: String) -> String {
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    func toDate(string: String) -> Date? {
        dateFormatter.dateFormat = formatToDate
        return dateFormatter.date(from: string)
    }
}
