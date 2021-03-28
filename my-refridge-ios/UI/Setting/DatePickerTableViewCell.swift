//
//  DatePickerTableViewCell.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/03/19.
//

import UIKit

class DatePickerTableViewCell: BaseTableViewCell {

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.notoSansKR(size: 16, family: .Medium)
        lbl.textColor = UIColor.refridgeColor(color: .gray)
        return lbl
    }()
    
//    private let pickField: UITextField = {
//        let field = UITextField()
//        field.font = UIFont.notoSansKR(size: 15, family: .Regular)
//        field.text = "오후 6:30"
//        return field
//    }()
    
    let picker: UIDatePicker = {
        let pick = UIDatePicker()
        
        pick.minuteInterval = 10
        pick.datePickerMode = .time
        pick.preferredDatePickerStyle = .inline
        pick.backgroundColor = .clear
        
        
        pick.addTarget(self, action: #selector(dateIsChanged), for: .valueChanged)
        return pick
    }()
    
    override func setup() {
        self.addSubview(titleLabel)
        self.addSubview(picker)
    }
    
    override func bindConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(13)
            make.left.equalToSuperview().inset(20)
        }
        picker.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.right.equalToSuperview().inset(20)
        }
    }
    
    @objc func dateIsChanged(sender: UIDatePicker) {
        let timeFormatter : DateFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short
        
        let selectedDate: String = timeFormatter.string(from: sender.date)
        print("Selected Value \(selectedDate)")
        //self.textField.text = selectedDate
    }
}
