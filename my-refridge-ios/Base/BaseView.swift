//
//  BaseView.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/02/12.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        bindConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {}
    
    func bindConstraints() {}
}
