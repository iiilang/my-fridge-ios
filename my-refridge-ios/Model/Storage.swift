//
//  Storage.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/07/07.
//

import Foundation

public class Storage {
    static func isFirstLaunch() -> Bool {
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "isFirstLaunch") == nil {
            defaults.set("No", forKey: "isFirstLaunch")
            return true
        } else {
            return false
        }
    }
    
}

struct UserInfo: Codable {
    var id: Int
    var uuid: String
}
