//
//  Food.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/03/08.
//

import Foundation

struct Food: Codable {
    var foodName: String
    var foodType: FoodType
    var foodMemo: String
    var expireAt: Date
    var registeredDate: Date
}

enum FoodType: String, Codable {
    case REF = "냉장"
    case FRE = "냉동"
    case ROOM = "실온"
}
