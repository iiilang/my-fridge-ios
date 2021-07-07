//
//  Setting.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/07/01.
//

import Foundation

struct Setting: Codable {
    var allowNoti: Bool = true
    var dayNoti: [Bool] = [true, true]
    var typeNoti: Bool? = true
    var time: Date = Date()
}
