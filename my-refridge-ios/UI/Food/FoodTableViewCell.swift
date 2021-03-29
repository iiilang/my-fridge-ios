//
//  FridgeSearchTableViewCell.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/03/10.
//

import UIKit

class FoodTableViewCell: BaseTableViewCell {
    
    var food: Food? {
        didSet {
            nameLabel.text = food?.foodName
            typeLabel.text = food?.foodType.rawValue
            
            if food?.foodType == .REF {
                typeView.backgroundColor = UIColor.refridgeColor(color: .orange)
            } else if food?.foodType == .FRE {
                typeView.backgroundColor = UIColor.refridgeColor(color: .green)
            } else {
                typeView.backgroundColor = UIColor.refridgeColor(color: .purple)
            }
            
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let expirationText = dateFormatter.string(from: (food?.expireAt ?? Date()) as Date)

            expirationLabel.text = "유통기한: " + expirationText

            let distanceHour = Calendar.current.dateComponents([.hour], from: food!.expireAt, to: Date()).hour ?? 0
            if distanceHour > 3 {
                warnIcon.isHidden = true
                warnLabel.isHidden = true
            }
            
            let memo = (food?.foodMemo == "") ? " " : food?.foodMemo
            memoLabel.text = memo
        }
    }
    
    private let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.notoSansKR(size: 16, family: .Medium)
        lbl.textColor = UIColor.refridgeColor(color: .black)
        return lbl
    }()
    
    private let typeView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        return view
    }()

    private let typeLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.notoSansKR(size: 12, family: .Medium)
        lbl.textColor = .white
        return lbl
    } ()
    
    private let expirationLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.notoSansKR(size: 15, family: .Regular)
        lbl.textColor = UIColor.refridgeColor(color: .gray)
        return lbl
    }()
    
    private let memoLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.notoSansKR(size: 15, family: .Regular)
        lbl.textColor = UIColor.refridgeColor(color: .gray)
        return lbl
    }()
    
    private let warnIcon = UIImageView(image: UIImage(named: "warn"))
    
    private let warnLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "유통기한 임박"
        lbl.font = UIFont.notoSansKR(size: 15, family: .Medium)
        lbl.textColor = UIColor.refridgeColor(color: .red)
        return lbl
    }()
    
    override func setup() {
        self.addSubview(nameLabel)
        self.addSubview(typeView)
        typeView.addSubview(typeLabel)
        self.addSubview(expirationLabel)
        self.addSubview(memoLabel)
        self.addSubview(warnIcon)
        self.addSubview(warnLabel)
    }
    
    override func bindConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.left.equalToSuperview().inset(20)
        }
        
        typeView.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.left.equalTo(nameLabel.snp.right).offset(5)
            make.height.equalTo(19)
            make.width.equalTo(41.5)
        }
        typeLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        expirationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.right.equalToSuperview().inset(20)
        }
        
        memoLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5.5)
            make.left.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(13)
        }
        
        warnIcon.snp.makeConstraints { make in
            make.centerY.equalTo(warnLabel.snp.centerY)
            make.right.equalTo(warnLabel.snp.left).offset(-5)
        }
        warnLabel.snp.makeConstraints { make in
            make.centerY.equalTo(memoLabel.snp.centerY)
            make.right.equalToSuperview().inset(20)
        }
    }
}


