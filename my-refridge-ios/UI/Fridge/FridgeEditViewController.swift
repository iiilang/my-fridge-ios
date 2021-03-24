//
//  FridgeEditViewController.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/03/16.
//

import UIKit

protocol SendFridgeDelegate {
    func sendFridge(data: Fridge, edit: Bool, tag: Int)
}

class FridgeEditViewController: UIViewController {
    
    var fridge: Fridge?
 
    var edit: Bool = false
    
    var tag: Int = -1
    
    var fridgeDelegate: SendFridgeDelegate?
    
    private let backButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "back"), for: .normal)
        btn.addTarget(self, action: #selector(back), for: .touchUpInside)
        return btn
    } ()
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.notoSansKR(size: 18, family: .Medium)
        lbl.text = "냉장고 추가"
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
    
    private let iconView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 55
        view.layer.borderWidth = 0.8
        view.layer.borderColor =  CGColor(red: 201/255, green: 205/255, blue: 210/255, alpha: 1)
        view.clipsToBounds = true
        return view
    }()
    
    private let icon: UIImageView = {
        let view = UIImageView(image: UIImage(named: "broccoliBig"))
        return view
    }()
    
    
    private let broccoliView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 30
        view.layer.borderWidth = 0.8
        view.layer.borderColor =  CGColor(red: 201/255, green: 205/255, blue: 210/255, alpha: 1)
        view.clipsToBounds = true
        return view
    }()
    
    private let broccoliButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "broccoli"), for: .normal)
        //btn.setImage(UIImage(named: "broccoli"), for: .highlighted)
        btn.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        btn.contentEdgeInsets = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
        return btn
    }()
    
    private let oilView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 30
        view.layer.borderWidth = 0.8
        view.layer.borderColor =  CGColor(red: 201/255, green: 205/255, blue: 210/255, alpha: 1)
        view.clipsToBounds = true
        return view
    }()
    
    private let oilButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "oil"), for: .normal)
        //btn.setImage(UIImage(named: "oil"), for: .highlighted)
        btn.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        btn.contentEdgeInsets = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
        return btn
    }()

    
    private let lettuceView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 30
        view.layer.borderWidth = 0.8
        view.layer.borderColor =  CGColor(red: 201/255, green: 205/255, blue: 210/255, alpha: 1)
        view.clipsToBounds = true
        return view
    }()
    
    private let lettuceButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "lettuce"), for: .normal)
        //btn.setImage(UIImage(named: "lettuce"), for: .highlighted)
        btn.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        btn.contentEdgeInsets = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
        return btn
    }()
    
    private let snackView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 30
        view.layer.borderWidth = 0.8
        view.layer.borderColor =  CGColor(red: 201/255, green: 205/255, blue: 210/255, alpha: 1)
        view.clipsToBounds = true
        return view
    }()
    
    private let snackButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "snack"), for: .normal)
        //btn.setImage(UIImage(named: "snack"), for: .highlighted)
        btn.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        btn.contentEdgeInsets = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
        return btn
    }()
    
    private let selectView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 247/255, green: 248/255, blue: 249/255, alpha: 0.77)
        view.layer.cornerRadius = 30
        return view
    }()
    
    private let selectIcon: UIImageView = {
        let view = UIImageView(image: UIImage(named: "check"))
        return view
    }()
    
    private let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "냉장고 이름"
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
        lbl.text = "냉장고 종류"
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
    
    private let typeIceButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("냉장/냉동", for: .normal)
        btn.titleLabel?.font = UIFont.notoSansKR(size: 15, family: .Medium)
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(pressTypeButton), for: .touchUpInside)
        return btn
    }()
    
    private let typeRoomButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("실온", for: .normal)
        btn.titleLabel?.font = UIFont.notoSansKR(size: 15, family: .Medium)
        btn.setTitleColor(UIColor.refridgeColor(color: .gray), for: .normal)
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(pressTypeButton), for: .touchUpInside)
        return btn
    }()
    
    private let basicLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "기본 냉장고"
        lbl.font = UIFont.notoSansKR(size: 16, family: .Medium)
        lbl.textColor = UIColor.refridgeColor(color: .black)
        return lbl
    }()
    
    private let basicRequiredIcon = UIImageView(image: UIImage(named: "required"))
    
    private let basicToggle: UISwitch = {
        let sch = UISwitch()
        sch.preferredStyle = .sliding
        sch.isOn = false
        sch.onTintColor = UIColor.refridgeColor(color: .blue)
        
        //off color
        sch.tintColor = UIColor.refridgeColor(color: .togglegray)
        sch.layer.cornerRadius = sch.frame.height / 2.0
        sch.backgroundColor = UIColor.refridgeColor(color: .togglegray)
        sch.clipsToBounds = true
        sch.addTarget(self, action: #selector(switchToggle), for: .valueChanged)
        
        return sch
    }()

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
        field.placeholder = "위치, 설명"
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
    
    init(title: String, fridge: Fridge, edit: Bool, tag: Int) {
        titleLabel.text = title
        self.fridge = fridge
        self.edit = edit
        self.tag = tag
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        self.view.addSubview(contentView)
        
        
        scrollView.addSubview(contentView)
        contentView.addSubview(iconView)
        iconView.addSubview(icon)
        //scrollView.isUserInteractionEnabled = true
        
        
        contentView.addSubview(broccoliView)
        broccoliView.addSubview(broccoliButton)
        contentView.addSubview(oilView)
        oilView.addSubview(oilButton)
        contentView.addSubview(lettuceView)
        lettuceView.addSubview(lettuceButton)
        contentView.addSubview(snackView)
        snackView.addSubview(snackButton)
        
        contentView.addSubview(selectView)
        selectView.addSubview(selectIcon)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(nameRequiredIcon)
        contentView.addSubview(nameField)
        contentView.addSubview(nameFieldLine)
        
        contentView.addSubview(typeLabel)
        contentView.addSubview(typeRequiredIcon)
        
        contentView.addSubview(typeView)
        typeView.addSubview(typeSelectView)
        typeView.addSubview(typeIceButton)
        typeView.addSubview(typeRoomButton)
        
        contentView.addSubview(basicLabel)
        contentView.addSubview(basicRequiredIcon)
        contentView.addSubview(basicToggle)
        
        contentView.addSubview(memoLabel)
        contentView.addSubview(memoField)
        contentView.addSubview(memoFieldLine)
        
        keyboardSetUp()
        
        //doneButton.isEnabled = false
        nameField.text = fridge?.name
        memoField.text = fridge?.memo
    }
    
    
    func keyboardSetUp() {
        nameField.delegate = self
        memoField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
        iconView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(21.5)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(110)
        }
        icon.snp.makeConstraints { make in
            make.center.equalTo(iconView.snp.center)
        }
        
        broccoliView.snp.makeConstraints { make in
            make.top.equalTo(iconView.snp.bottom).offset(25)
            make.right.equalTo(oilView.snp.left).offset(-15)
            make.width.height.equalTo(60)
        }
        broccoliButton.snp.makeConstraints { make in
            make.center.equalTo(broccoliView.snp.center)
        }
        oilView.snp.makeConstraints { make in
            make.centerY.equalTo(broccoliView.snp.centerY)
            make.centerX.equalToSuperview().offset(-37.5)
            make.width.height.equalTo(60)
        }
        oilButton.snp.makeConstraints { make in
            make.center.equalTo(oilView.snp.center)
        }
        lettuceView.snp.makeConstraints { make in
            make.centerY.equalTo(broccoliView.snp.centerY)
            make.centerX.equalToSuperview().offset(37.5)
            make.width.height.equalTo(60)
        }
        lettuceButton.snp.makeConstraints { make in
            make.center.equalTo(lettuceView.snp.center)
        }
        snackView.snp.makeConstraints { make in
            make.centerY.equalTo(broccoliView.snp.centerY)
            make.left.equalTo(lettuceView.snp.right).offset(15)
            make.width.height.equalTo(60)
        }
        snackButton.snp.makeConstraints { make in
            make.center.equalTo(snackView.snp.center)
            
        }
        
        var someView = broccoliView
        if fridge?.icon == "broccoli" {
            icon.image = UIImage(named: "broccoliBig")
            someView = broccoliView
        } else if fridge?.icon == "oil" {
            icon.image = UIImage(named: "oil")
            someView = oilView
        } else if fridge?.icon == "lettuce" {
            icon.image = UIImage(named: "lettuce")
            someView = lettuceView
        } else if fridge?.icon == "snack" {
            icon.image = UIImage(named: "snack")
            someView = snackView
        }
        
        selectView.snp.makeConstraints { make in
            make.center.equalTo(someView)
            make.width.height.equalTo(60)
        }
        selectIcon.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(broccoliView.snp.bottom).offset(30)
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
        
        var sCenter = typeIceButton.snp.centerX
        if fridge?.type == "냉장/냉동" {
            sCenter = typeIceButton.snp.centerX
            typeIceButton.setTitleColor(.white, for: .normal)
            typeRoomButton.setTitleColor(UIColor.refridgeColor(color: .gray), for: .normal)
        } else if fridge?.type == "실온" {
            sCenter = typeRoomButton.snp.centerX
            typeRoomButton.setTitleColor(.white, for: .normal)
            typeIceButton.setTitleColor(UIColor.refridgeColor(color: .gray), for: .normal)
        }
        
        typeSelectView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalTo(sCenter)
            make.width.equalTo(86)
            make.height.equalTo(33)
        }
        typeIceButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(-46.25)
        }
        typeRoomButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(46.25)
        }
        
        basicLabel.snp.makeConstraints { make in
            make.top.equalTo(typeLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().inset(20)
        }
        basicRequiredIcon.snp.makeConstraints { make in
            make.centerY.equalTo(basicLabel)
            make.left.equalTo(basicLabel.snp.right).offset(3.5)
        }
        basicToggle.snp.makeConstraints { make in
            make.centerY.equalTo(basicLabel)
            make.right.equalToSuperview().inset(20)
        }
        
        memoLabel.snp.makeConstraints { make in
            make.top.equalTo(basicLabel.snp.bottom).offset(31.5)
            make.left.equalToSuperview().inset(20)
        }
        memoField.snp.makeConstraints { make in
            make.top.equalTo(memoLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(18)
        }
        memoFieldLine.snp.makeConstraints { make in
            make.top.equalTo(memoField.snp.bottom).offset(8)
            make.left.right.bottom.equalToSuperview().inset(17)
            make.height.equalTo(0.8)
        }
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func done() {
        self.fridge?.name = nameField.text ?? " "
        let memo = memoField.text ?? " "
        self.fridge?.memo = (memo == "") ? " " : memo

        
        if fridge?.name != "", fridge?.name != " " {
            fridgeDelegate?.sendFridge(data: fridge!, edit: self.edit, tag: self.tag)
            navigationController?.popViewController(animated: true)
        }
    }
    
    
    @objc func pressButton(sender: UIButton) {
        selectView.snp.remakeConstraints { make in
            make.width.height.equalTo(60)
            make.center.equalTo(sender)
            
        }
        //selectView.isHidden = sender.isSelected
        
        if sender == broccoliButton {
            icon.image = UIImage(named: "broccoliBig")
            fridge?.icon = "broccoli"
        } else if sender == oilButton {
            icon.image = UIImage(named: "oil")
            fridge?.icon = "oil"
        } else if sender == lettuceButton {
            icon.image = UIImage(named: "lettuce")
            fridge?.icon = "lettuce"
        } else if sender == snackButton {
            icon.image = UIImage(named: "snack")
            fridge?.icon = "snack"
        }
    }
    
    @objc func pressTypeButton(sender: UIButton) {
        var centerX = -46.25
        if sender == typeIceButton {
            centerX = -46.25
            fridge?.type = "냉장/냉동"
            typeIceButton.setTitleColor(.white, for: .normal)
            typeRoomButton.setTitleColor(UIColor.refridgeColor(color: .gray), for: .normal)
        } else if sender == typeRoomButton {
            centerX = 46.25
            fridge?.type = "실온"
            typeIceButton.setTitleColor(UIColor.refridgeColor(color: .gray), for: .normal)
            typeRoomButton.setTitleColor(.white, for: .normal)
        }
        
        typeSelectView.snp.remakeConstraints { make in
            make.centerY.equalTo(typeView.snp.centerY)
            make.centerX.equalTo(typeView.snp.centerX).offset(centerX)
            make.width.equalTo(86)
            make.height.equalTo(33)
        }
    }
    
    @objc func switchToggle(sender: UISwitch) {
        fridge?.isBasic = sender.isOn
    }
}




// MARK: - Text Field Delegate

extension FridgeEditViewController: UITextFieldDelegate {
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let text = nameField.text ?? " "
        self.fridge?.name = text
        if text != "", text != " " {
            doneButton.setTitleColor(UIColor.refridgeColor(color: .blue), for: .normal)
        }
        
        self.fridge?.memo = memoField.text ?? " "
        
        
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        if textField == self.nameField {
            if let text = textField.text {
                if text != "", text != " " {
                    doneButton.setTitleColor(UIColor.refridgeColor(color: .blue), for: .normal)
                }
                self.fridge?.name = text
            }
        } else if textField == self.memoField {
            if let text = textField.text {
                self.fridge?.memo = text
            }
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return !(textField.text!.count > 20) //20자 제한.
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardHeight = keyboardFrame.height
        
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight , right: 0)
            self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset
        })
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.scrollView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
            self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset
        })
    }

}

extension FridgeEditViewController: UIScrollViewDelegate {
    //가로 방향 스크롤막기
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x > 0 {
            scrollView.contentOffset.x = 0
        }
    }
}
