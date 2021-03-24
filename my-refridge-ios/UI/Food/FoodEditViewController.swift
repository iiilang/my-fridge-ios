//
//  FoodEditViewController.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/03/24.
//

import UIKit

class FoodEditViewController: UIViewController {
    
    //var fridge: Fridge
    
    var food: Food? {
        didSet {
            // typeView, typeIceButton -> 실온일때 처리
        }
    }
    
    var edit: Bool = false
    
    private let backButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "back"), for: .normal)
        btn.addTarget(self, action: #selector(back), for: .touchUpInside)
        return btn
    } ()
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.notoSansKR(size: 18, family: .Medium)
        lbl.text = "식품 추가"
        lbl.textColor = UIColor.refridgeColor(color: .black)
        return lbl
    }()
    
    private let doneButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("완료", for: .normal)
        btn.setTitleColor(UIColor(hex: "#9EA4AAFF"), for: .normal)
        btn.titleLabel?.font = UIFont.notoSansKR(size: 16, family: .Medium)
        btn.addTarget(self, action: #selector(done), for: .touchUpInside)
        return btn
    } ()
    
    private let line = UIImageView(image: UIImage(named: "lineShop"))
    
    private let scrollView = UIScrollView()
    
    private let contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "식품명"
        lbl.font = UIFont.notoSansKR(size: 16, family: .Medium)
        lbl.textColor = UIColor.refridgeColor(color: .black)
        return lbl
    }()
    
    private let nameRequiredIcon = UIImageView(image: UIImage(named: "required"))
    
    private let nameField: UITextField = {
        let field = UITextField()
        field.font = UIFont.notoSansKR(size: 15, family: .Regular)
        return field
    }()
    
    private let nameFieldLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.refridgeColor(color: .lightgray)
        view.clipsToBounds = true
        view.layer.borderWidth = 0.8
        view.layer.borderColor = CGColor(red: 201/255, green: 205/255, blue: 210/255, alpha: 1)
        return view
    }()
    
    private let typeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "식품 종류"
        lbl.font = UIFont.notoSansKR(size: 16, family: .Medium)
        lbl.textColor = UIColor.refridgeColor(color: .black)
        return lbl
    }()
    
    private let typeRequiredIcon = UIImageView(image: UIImage(named: "required"))
    
    private let typeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 247/255, green: 248/255, blue: 249/255, alpha: 1)
        view.layer.cornerRadius = 19
        return view
    }()
    
    private let typeSelectView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.refridgeColor(color: .blue)
        view.layer.cornerRadius = 16.5
        return view
    }()
    
    private let typeColdButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("냉장", for: .normal)
        btn.titleLabel?.font = UIFont.notoSansKR(size: 15, family: .Medium)
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(pressTypeButton), for: .touchUpInside)
        return btn
    }()
    
    private let typeIceButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("냉동", for: .normal)
        btn.titleLabel?.font = UIFont.notoSansKR(size: 15, family: .Medium)
        btn.setTitleColor(UIColor.refridgeColor(color: .gray), for: .normal)
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(pressTypeButton), for: .touchUpInside)
        return btn
    }()
    
    private let expirationLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "유통기한"
        lbl.font = UIFont.notoSansKR(size: 16, family: .Medium)
        lbl.textColor = UIColor.refridgeColor(color: .black)
        return lbl
    }()
    
    private let expirationRequiredIcon = UIImageView(image: UIImage(named: "required"))
    
    private let expirationDate: UIDatePicker = {
        let pick = UIDatePicker()
        pick.minuteInterval = 10
        pick.datePickerMode = .date
        pick.preferredDatePickerStyle = .compact
        pick.backgroundColor = .clear
        
        return pick
    } ()
    
    private let enrollLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "등록일"
        lbl.font = UIFont.notoSansKR(size: 16, family: .Medium)
        lbl.textColor = UIColor.refridgeColor(color: .black)
        return lbl
    }()
    
    private let enrollDate: UILabel = {
        let lbl = UILabel()
        lbl.text = "2020-03-24"
        lbl.font = UIFont.notoSansKR(size: 16, family: .Medium)
        lbl.textColor = UIColor.refridgeColor(color: .black)
        return lbl
    } ()
    
    private let memoLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "메모"
        lbl.font = UIFont.notoSansKR(size: 16, family: .Medium)
        lbl.textColor = UIColor.refridgeColor(color: .black)
        return lbl
    }()
    
    private let memoField: UITextField = {
        let field = UITextField()
        field.font = UIFont.notoSansKR(size: 15, family: .Regular)
        field.placeholder = "수량, 보관방법, 특이사항"
        return field
    }()
    
    private let memoFieldLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.refridgeColor(color: .lightgray)
        view.clipsToBounds = true
        view.layer.borderWidth = 0.8
        view.layer.borderColor = CGColor(red: 201/255, green: 205/255, blue: 210/255, alpha: 1)
        return view
    }()
    
    private let fridgeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "냉장고"
        lbl.font = UIFont.notoSansKR(size: 16, family: .Medium)
        lbl.textColor = UIColor.refridgeColor(color: .black)
        return lbl
    }()
    
    private let fridgeRequiredIcon = UIImageView(image: UIImage(named: "required"))
    
    private let fridgeSelectLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "주방 냉장고"
        lbl.font = UIFont.notoSansKR(size: 16, family: .Medium)
        lbl.textColor = UIColor.refridgeColor(color: .black)
        return lbl
    } ()

    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func done() {
//        self.fridge?.name = nameField.text ?? " "
//        let memo = memoField.text ?? " "
//        self.fridge?.memo = (memo == "") ? " " : memo
//
//
//        if fridge?.name != "", fridge?.name != " " {
//            fridgeDelegate?.sendFridge(data: fridge!, edit: self.edit, tag: self.tag)
//            navigationController?.popViewController(animated: true)
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindConstraints()
    }
    
    func setup() {
        self.view.backgroundColor = .white
        self.view.addSubview(backButton)
        self.view.addSubview(titleLabel)
        self.view.addSubview(doneButton)
        self.view.addSubview(line)
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(nameRequiredIcon)
        contentView.addSubview(nameField)
        contentView.addSubview(nameFieldLine)
        
        contentView.addSubview(typeLabel)
        contentView.addSubview(typeRequiredIcon)
        contentView.addSubview(typeView)
        typeView.addSubview(typeSelectView)
        typeView.addSubview(typeColdButton)
        typeView.addSubview(typeIceButton)
        
        contentView.addSubview(expirationLabel)
        contentView.addSubview(expirationRequiredIcon)
        contentView.addSubview(expirationDate)
        
        contentView.addSubview(enrollLabel)
        contentView.addSubview(enrollDate)
        
        contentView.addSubview(memoLabel)
        contentView.addSubview(memoField)
        contentView.addSubview(memoFieldLine)
        
        contentView.addSubview(fridgeLabel)
        contentView.addSubview(fridgeRequiredIcon)
        contentView.addSubview(fridgeSelectLabel)
    }
    
    func bindConstraints() {
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.left.equalTo(self.view).inset(20)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.centerX.equalTo(self.view)
        }
        doneButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.right.equalTo(self.view).inset(20)
        }
        line.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8.5)
            make.left.right.equalTo(self.view)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom)
            make.left.right.bottom.equalToSuperview()
            make.width.equalTo(contentView.snp.width)
        }
        contentView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27.5)
            make.left.equalToSuperview().inset(20)
        }
        nameRequiredIcon.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp.right).offset(3.5)
        }
        nameField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(18)
        }
        nameFieldLine.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(17)
            make.height.equalTo(0.8)
        }
        
        typeLabel.snp.makeConstraints { make in
            make.top.equalTo(nameFieldLine.snp.bottom).offset(28)
            make.left.equalToSuperview().inset(20)
        }
        typeRequiredIcon.snp.makeConstraints { make in
            make.centerY.equalTo(typeLabel)
            make.left.equalTo(typeLabel.snp.right).offset(3.5)
        }
        
        typeView.snp.makeConstraints { make in
            make.centerY.equalTo(typeLabel)
            make.right.equalToSuperview().inset(20)
            make.width.equalTo(185)
            make.height.equalTo(38)
        }
        
        var sCenter = typeColdButton.snp.centerX
        if food?.type == "냉장" {
            sCenter = typeIceButton.snp.centerX
            typeColdButton.setTitleColor(.white, for: .normal)
            typeIceButton.setTitleColor(UIColor.refridgeColor(color: .gray), for: .normal)
        } else if food?.type == "냉동" {
            sCenter = typeIceButton.snp.centerX
            typeColdButton.setTitleColor(.white, for: .normal)
            typeIceButton.setTitleColor(UIColor.refridgeColor(color: .gray), for: .normal)
        }
        
        typeSelectView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalTo(sCenter)
            make.width.equalTo(86)
            make.height.equalTo(33)
        }
        typeColdButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(-46.25)
        }
        typeIceButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(46.25)
        }
        
        
        expirationLabel.snp.makeConstraints { make in
            make.top.equalTo(typeLabel.snp.bottom).offset(27.5)
            make.left.equalToSuperview().inset(20)
        }
        expirationRequiredIcon.snp.makeConstraints { make in
            make.centerY.equalTo(expirationLabel)
            make.left.equalTo(typeLabel.snp.right).offset(3.5)
        }
        expirationDate.snp.makeConstraints { make in
            make.centerY.equalTo(expirationLabel)
            make.right.equalToSuperview().inset(20)
        }
        
        expirationLabel.snp.makeConstraints { make in
            make.top.equalTo(typeLabel.snp.bottom).offset(27.5)
            make.left.equalToSuperview().inset(20)
        }
        expirationRequiredIcon.snp.makeConstraints { make in
            make.centerY.equalTo(expirationLabel)
            make.left.equalTo(typeLabel.snp.right).offset(3.5)
        }
        expirationDate.snp.makeConstraints { make in
            make.centerY.equalTo(expirationLabel)
            make.right.equalToSuperview().inset(20)
        }
        
        enrollLabel.snp.makeConstraints { make in
            make.top.equalTo(expirationLabel.snp.bottom).offset(27.5)
            make.left.equalToSuperview().inset(20)
        }
        enrollDate.snp.makeConstraints { make in
            make.centerY.equalTo(enrollLabel)
            make.right.equalToSuperview().inset(20)
        }
        
        memoLabel.snp.makeConstraints { make in
            make.top.equalTo(enrollLabel.snp.bottom).offset(31.5)
            make.left.equalToSuperview().inset(20)
        }
        memoField.snp.makeConstraints { make in
            make.top.equalTo(memoLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(18)
        }
        memoFieldLine.snp.makeConstraints { make in
            make.top.equalTo(memoField.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(17)
            make.height.equalTo(0.8)
        }
        
        fridgeLabel.snp.makeConstraints { make in
            make.top.equalTo(memoFieldLine.snp.bottom).offset(27.5)
            make.left.equalToSuperview().inset(20)
        }
        fridgeRequiredIcon.snp.makeConstraints { make in
            make.centerY.equalTo(fridgeLabel)
            make.left.equalTo(fridgeLabel.snp.right).offset(3.5)
        }
        fridgeSelectLabel.snp.makeConstraints { make in
            make.centerY.equalTo(fridgeLabel)
            make.right.bottom.equalToSuperview().inset(20)
        }
    }
    
    @objc func pressTypeButton(sender: UIButton) {
        var centerX = -46.25
        if sender == typeColdButton {
            centerX = -46.25
            food?.type = "냉장"
            typeColdButton.setTitleColor(.white, for: .normal)
            typeIceButton.setTitleColor(UIColor.refridgeColor(color: .gray), for: .normal)
        } else if sender == typeIceButton {
            centerX = 46.25
            food?.type = "냉동"
            typeColdButton.setTitleColor(UIColor.refridgeColor(color: .gray), for: .normal)
            typeIceButton.setTitleColor(.white, for: .normal)
        }
        
        typeSelectView.snp.remakeConstraints { make in
            make.centerY.equalTo(typeView.snp.centerY)
            make.centerX.equalTo(typeView.snp.centerX).offset(centerX)
            make.width.equalTo(86)
            make.height.equalTo(33)
        }
    }
}
