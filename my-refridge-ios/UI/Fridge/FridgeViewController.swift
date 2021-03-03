//
//  ViewController.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/02/11.
//

import UIKit
import SnapKit

class FridgeViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "마이 냉장고"
        lbl.font = UIFont.notoSansKR(size: 22, family: .Bold)
        return lbl
    }()
    
    let searchButton: UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage(named: "search"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.addTarget(self, action: #selector(pressSearchButton), for: .touchUpInside)
        return btn
    }()
    
    let setButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "setting"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.addTarget(self, action: #selector(pressSetButton), for: .touchUpInside)
        return btn
    }()
    
    let plusButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "plus"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.addTarget(self, action: #selector(pressPlusButton), for: .touchUpInside)
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
        self.view.addSubview(titleLabel)
        self.view.addSubview(searchButton)
        self.view.addSubview(setButton)
        self.view.addSubview(plusButton)
    }
    
    func bindConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaInsets).inset(44)
            make.left.equalTo(self.view).inset(20)
        }
        searchButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.right.equalTo(setButton.snp.left).offset(-10)
        }
        setButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.right.equalTo(self.view).inset(15)
        }
        plusButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaInsets.bottom).inset(15.5)
            make.right.equalTo(self.view).inset(20)
        }
    }
    
    @objc func pressSearchButton() {
        print("search")
    }

    @objc func pressSetButton() {
        print("setting")
    }
    
    @objc func pressPlusButton() {
        print("plus")
    }
}

