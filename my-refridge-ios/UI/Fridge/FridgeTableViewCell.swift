//
//  FridgeCollectionViewCell.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/03/08.
//

import UIKit
import SnapKit

protocol FridgeTableViewCellDelegate {
    func pressMoreButton(_ tag: Int)
}

class FridgeTableViewCell: BaseTableViewCell {
    
    var cellDelegate: FridgeTableViewCellDelegate?
    
    var fridge: Fridge? {
        didSet {
            icon.image = UIImage(named: fridge?.fridgeIcon ?? "")
            nameLabel.text = fridge?.fridgeName
            
            let memo = (fridge?.fridgeMemo == "") ? " " : fridge?.fridgeMemo
            memoLabel.text = memo
            
            if fridge?.fridgeType == .REFRE {
                typeLabel.text = "냉장"
                typeView.backgroundColor = UIColor.refridgeColor(color: .orange)
                iceView.isHidden = false
            } else {
                typeLabel.text = "실온"
                typeView.backgroundColor = UIColor.refridgeColor(color: .purple)
                iceView.isHidden = true
            }
            basicMark.isHidden = !(fridge?.fridgeBasic ?? false)
        }
    }
    
    private let backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor.refridgeColor(color: .backgray)
        return view
    }()
    
    private let iconView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        return view
    }()
    
    private let icon: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.notoSansKR(size: 16, family: .Medium)
        lbl.textColor = UIColor.refridgeColor(color: .black)
        return lbl
    }()
    
    private let typeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.refridgeColor(color: .orange)
        view.layer.cornerRadius = 10
        return view
    }()

    private let typeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "냉장"
        lbl.font = UIFont.notoSansKR(size: 12, family: .Medium)
        lbl.textColor = .white
        return lbl
    } ()
    
    private let iceView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.refridgeColor(color: .green)
        view.layer.cornerRadius = 10
        return view
    }()

    private let iceLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "냉동"
        lbl.font = UIFont.notoSansKR(size: 12, family: .Medium)
        lbl.textColor = .white
        return lbl
    } ()
    
    private let basicMark = UIImageView(image: UIImage(named: "basic"))
    
    private let memoLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.notoSansKR(size: 15, family: .Regular)
        lbl.textColor = UIColor.refridgeColor(color: .gray)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let moreButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "more"), for: .normal)
        btn.contentMode = .scaleAspectFill
        btn.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        return btn
    }()
    
    @objc func pressMoreButton(sender: UIButton) {
        cellDelegate?.pressMoreButton(sender.tag)
    }
    
    override func setup() {
        self.backgroundColor = .white
        self.addSubview(backView)
        backView.addSubview(iconView)
        iconView.addSubview(icon)
        backView.addSubview(nameLabel)
        
        backView.addSubview(typeView)
        typeView.addSubview(typeLabel)
        backView.addSubview(iceView)
        iceView.addSubview(iceLabel)
        
        backView.addSubview(basicMark)
        backView.addSubview(memoLabel)
        backView.addSubview(moreButton)
        
        moreButton.addTarget(self, action: #selector(pressMoreButton), for: .touchUpInside)
    }
    
    override func bindConstraints() {
        backView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(7.5)
            make.left.right.equalToSuperview().inset(20)
        }
        iconView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(12.5)
            make.width.height.equalTo(50)
        }
        icon.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.left.equalTo(iconView.snp.right).offset(10)
        }
        
        typeView.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.left.equalTo(nameLabel.snp.right).offset(5)
            make.height.equalTo(20)
            make.width.equalTo(42)
        }
        typeLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        iceView.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.left.equalTo(typeView.snp.right).offset(5)
            make.height.equalTo(20)
            make.width.equalTo(42)
        }
        iceLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        basicMark.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(285)
            make.top.equalToSuperview().offset(-2.5)
        }
        memoLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5.5)
            make.left.equalTo(iconView.snp.right).offset(10)
            make.bottom.equalToSuperview().inset(15)
        }
        moreButton.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            
            make.right.equalToSuperview().inset(13.5 - 12)
        }
    }
}
