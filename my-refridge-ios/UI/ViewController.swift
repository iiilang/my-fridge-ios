//
//  ViewController.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/02/11.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let testButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("button", for: .normal)
        btn.backgroundColor = .orange
        btn.titleLabel?.font = UIFont.notoSansKR()
        btn.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        return btn
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white

        setup()
        bindConstraints()
    }

    func setup() {
        self.view.addSubview(testButton)
    }
    
    func bindConstraints() {
        testButton.snp.makeConstraints { make in
            make.left.right.equalTo(self.view).inset(120)
            make.centerX.centerY.equalTo(self.view)
        }
    }
    
    @objc func pressButton() {
        print("button")
    }

}

