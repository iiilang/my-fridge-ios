//
//  Food.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/03/08.
//

import Foundation

struct Food: Codable {
    var foodId: Int = 0
    var foodName: String
    var foodType: FoodType
    var foodMemo: String
    var expireAt: String
    var createdAt: String
    var fridgeId: Int
}

enum FoodType: String, Codable {
    case REFRIGERATED = "REFRIGERATED"
    case FROZEN = "FROZEN"
    case ROOM = "ROOM"
}
