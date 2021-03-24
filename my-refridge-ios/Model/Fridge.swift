//
//  Fridge.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/03/08.
//

import Foundation

struct Fridge: Codable {
    
    var icon: String
    var name: String
    var type: String
    var memo: String
    var isBasic: Bool = false
    
    var foods = [Food]()
}
