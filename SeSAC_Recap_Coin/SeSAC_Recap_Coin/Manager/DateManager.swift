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
    
    private let dateFormatter: DateFormatter = {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        format.timeZone = TimeZone(identifier: "Asia/Seoul")
        return format
    }()
    
    func toString(date: Date, format: String) -> String {
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    func toDate(string: String) -> Date? {
        return dateFormatter.date(from: string)
    }
}
