//
//  Date+Extension.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/05/12.
//

import Foundation

extension Date {
    func dateToString() -> String {
        
        let dateForamtter = DateFormatter()
        dateForamtter.dateFormat = "yyyy-MM-dd"
        
        let dateString = dateForamtter.string(from: self)
        
        return dateString
    }
}
