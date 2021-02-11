//
//  ShoppingViewController.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/02/11.
//

import UIKit

class ShoppingViewController:
    UIViewController {
    
    let copyButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "copy"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        return btn
    }()
    
    let label: UILabel = {
        let lbl = UILabel()
        lbl.text = "장보기 메모"
        lbl.font = UIFont.notoSansKR(size: 18, family: .Medium)
        return lbl
    }()
    
    
    let deleteButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "delete"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        return btn
    } ()
    
    let line = UIImageView(image: UIImage(named: "lineShop"))
    
    let dateLabel: UILabel = {
        let lbl = UILabel()
        let now = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        lbl.text = dateFormatter.string(from: now as Date)
        lbl.font = UIFont.notoSansKR(size: 18, family: .Medium)
        return lbl
    }()
    
    //let shopTableView: UITableView

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        makeConstraints()
    }
    
    func setup() {
        self.view.addSubview(copyButton)
        self.view.addSubview(label)
        self.view.addSubview(deleteButton)
        self.view.addSubview(line)
        self.view.addSubview(dateLabel)
        self.view.backgroundColor = .white
    }
    
    func makeConstraints() {
        copyButton.snp.makeConstraints { make in
            make.centerY.equalTo(label)
            make.left.equalTo(self.view).inset(15)
        }
        label.snp.makeConstraints { make in
            make.top.equalTo(self.view).inset(45.5)
            make.left.right.equalTo(self.view).inset(144)
            
        }
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(label)
            make.right.equalTo(self.view).inset(16)
        }
        line.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(8.5)
            make.left.right.equalTo(self.view)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(12)
            make.left.equalTo(self.view).inset(20)
        }
    }
}
