//
//  String+Extension.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/02/13.
//

import Foundation
import UIKit

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let range = NSMakeRange(0, attributedString.length)
        
        attributedString.addAttribute(.strikethroughStyle, value: 1, range: range)
        
        return attributedString
        
    }
   
}
