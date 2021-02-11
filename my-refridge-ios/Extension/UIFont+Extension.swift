//
//  UIFont Extension.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/02/11.
//

import UIKit

extension UIFont {
    
    enum Family: String {
        case Black, Bold, Light, Medium, Regular, Thin
    }
    
    static func notoSansKR(size: CGFloat = 15, family: Family = .Medium) -> UIFont {
        return UIFont(name: "NotoSansKR-\(family)", size: size)!
    }
    
    
    private static func customFont(name: String, size: CGFloat) -> UIFont {
        let font = UIFont(name: name, size: size)
        assert(font != nil, "Can't load font: \(name)")
        return font ?? UIFont.systemFont(ofSize: size)
    }
    
    static func mainFont(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "NotoSansKR-Black", size: size)
    }
}
