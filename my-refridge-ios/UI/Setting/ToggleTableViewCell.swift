//
//  ToggleTableViewCell.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/03/19.
//

import UIKit

protocol ToggleTableViewCellDelegate {
    func switchAllowToggle(sender: UISwitch)
}

class ToggleTableViewCell: BaseTableViewCell {
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var cellDelegate: ToggleTableViewCellDelegate?

    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.notoSansKR(size: 15, family: .Regular)
        lbl.textColor = UIColor.refridgeColor(color: .gray)
        return lbl
    }()
    
    let toggle: UISwitch = {
        let sch = UISwitch()
        sch.preferredStyle = .sliding
        //sch.isOn = true
        sch.onTintColor = UIColor.refridgeColor(color: .blue)
        
        //off color
        sch.tintColor = UIColor.refridgeColor(color: .togglegray)
        sch.layer.cornerRadius = sch.frame.height / 2.0
        sch.backgroundColor = UIColor.refridgeColor(color: .togglegray)
        sch.clipsToBounds = true
        
        return sch
    }()
    
    override func setup() {
        self.addSubview(titleLabel)
        self.addSubview(toggle)
        toggle.addTarget(self, action: #selector(switchToggle), for: .valueChanged)
    }
    
    override func bindConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(13)
            make.left.equalToSuperview().inset(20)
        }
        toggle.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.right.equalToSuperview().inset(20)
        }
    }
    
    @objc func switchToggle(sender: UISwitch) {
        //cellDelegate?.switchAllowToggle(sender: sender)
    }
}
