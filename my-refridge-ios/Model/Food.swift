//
//  Food.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/03/08.
//

import Foundation

struct Food: Codable {
    var name: String
    var type: String
    var registeredDate: Date
    var expirationDate: Date
    var memo: String
    //var fridgeId: Int
}
