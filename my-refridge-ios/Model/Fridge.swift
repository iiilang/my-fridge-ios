//
//  Fridge.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/03/08.
//

import Foundation

struct Fridge: Codable {
    
    var fridgeName: String
    var fridgeIcon: String
    var fridgeBasic: Bool = false
    var fridgeType: FridgeType
    var fridgeMemo: String
    
    var foods = [Food]()
}

enum FridgeType: String, Codable {
    case REFRE = "냉장/냉동"
    case ROOM = "실온"
}
