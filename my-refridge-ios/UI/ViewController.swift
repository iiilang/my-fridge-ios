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
        return btn
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(testButton)
        testButton.snp.makeConstraints { make in
            make.left.right.equalTo(self.view).inset(120)
            make.centerX.centerY.equalTo(self.view)
            
        }
    }


}

