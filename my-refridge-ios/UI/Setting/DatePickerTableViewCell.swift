//
//  DatePickerTableViewCell.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/03/19.
//

import UIKit

protocol DatePickerTableViewCellDelegate {
    func chooseAlarmTime(time: Date)
}

class DatePickerTableViewCell: BaseTableViewCell {

    
    var cellDelegate: DatePickerTableViewCellDelegate?
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var time: Date? {
        didSet {
            //초기 date 설정
            
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ko_KR")
            dateFormatter.dateFormat = "a hh:mm"
            
            let time: String = dateFormatter.string(from: time ?? Date())
            pickField.text = time
        }
    }

    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.notoSansKR(size: 16, family: .Medium)
        lbl.textColor = UIColor.refridgeColor(color: .gray)
        return lbl
    }()
    
    private let pickField: UITextField = {
        let field = UITextField()
        field.font = UIFont.notoSansKR(size: 15, family: .Regular)
        field.tintColor = .clear
        //field.text = "오후 6:30"
        return field
    }()
    
    let picker: UIDatePicker = {
        let pick = UIDatePicker()
        
        pick.minuteInterval = 10
        pick.datePickerMode = .time
        pick.preferredDatePickerStyle = .inline
        pick.backgroundColor = .clear
        pick.locale = Locale(identifier: "ko_KR")
        
        return pick
    }()
    
    @objc func setAlarmTime(sender: UIDatePicker) {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "a hh:mm"
        
        let selectedDate: String = dateFormatter.string(from: sender.date)
        pickField.text = selectedDate
        
        cellDelegate?.chooseAlarmTime(time: sender.date)
    }
    
    override func setup() {
        self.addSubview(titleLabel)
        self.addSubview(pickField)
        if #available(iOS 14, *) {
            picker.sizeToFit()
            picker.preferredDatePickerStyle = .wheels
        }
        pickField.inputView = picker
        picker.addTarget(self, action: #selector(setAlarmTime), for: .valueChanged)
        
    }
    
    override func bindConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(13)
            make.left.equalToSuperview().inset(20)
        }
        pickField.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.right.equalToSuperview().inset(20)
        }
    }
}
