//
//  FoodEditViewController.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/03/24.
//

import UIKit

protocol SendFoodDelegate {
    func sendFood(food: Food, edit: Bool, tag: Int, fridgeTag: Int, changeFridgeTag: Int)
}

class FoodEditViewController: UIViewController {
    
    // MARK: - variables
    var fridges: [Fridge]?
    var fridgeTag: Int
    var changeFridgeTag: Int //바뀔 냉장고.
    
    var fridge: Fridge?
    var food: Food?
    
    var edit: Bool = false
    var tag: Int = -1
    var foodDelegate: SendFoodDelegate?
    
    
    // MARK: - Initialization
    
    init(fridgeTag: Int, fridge: Fridge, food: Food, edit: Bool, tag: Int) {
        self.fridgeTag = fridgeTag
        self.changeFridgeTag = fridgeTag
        self.fridge = fridge
        titleLabel.text = edit ? "식품 편집" : "식품 추가"
        self.edit = edit
        self.food = food
        self.tag = tag
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
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
    
    private let line = UIImageView(image: UIImage(named: "line"))
    
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

    
    private let expirationDate: UITextField = {
        let fld = UITextField()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        fld.text = dateFormatter.string(from: Date() as Date)
        fld.tintColor = .clear
        fld.font = UIFont.notoSansKR(size: 15, family: .Regular)
        fld.textColor = UIColor.refridgeColor(color: .black)
            
        return fld
    } ()

    private let expirationDatePicker: UIDatePicker = {
        let pick = UIDatePicker()
        pick.datePickerMode = .date
        if #available(iOS 14, *) {
            pick.preferredDatePickerStyle = .wheels
            
        }
        pick.backgroundColor = .clear
        pick.addTarget(self, action: #selector(setExpDate), for: .valueChanged)
        pick.locale = Locale(identifier: "ko_KR")
        
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
        lbl.font = UIFont.notoSansKR(size: 15, family: .Regular)
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
    
    private let fridgeSelectField: UITextField = {
        let fld = UITextField()
        fld.font = UIFont.notoSansKR(size: 15, family: .Regular)
        fld.textColor = UIColor.refridgeColor(color: .black)
        fld.tintColor = .clear
        return fld
    } ()
    
    private lazy var fridgePicker: UIPickerView = {
        let pick = UIPickerView()
        pick.delegate = self
        pick.dataSource = self
        pick.backgroundColor = .clear

        return pick
    } ()

    
    // MARK: - add target functions
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func done() {
        if let name = nameField.text {
            self.food?.foodName = name
        }
        
        let memo = memoField.text ?? ""
        self.food?.foodMemo = (memo == "") ? " ": memo
        
        self.food?.foodMemo = memoField.text ?? ""
        
        let distanceHour = Calendar.current.dateComponents([.hour], from: food!.registeredDate, to: food!.expireAt).hour ?? 0

        if food?.foodName == "" {
            nameField.resignFirstResponder()
            memoField.resignFirstResponder()
            showToast(message: "이름을 넣어주세요.")
        } else if distanceHour < 0 {
            nameField.resignFirstResponder()
            memoField.resignFirstResponder()
            showToast(message: "유통기한을 다시 설정해주세요.")
        }
        else {
            foodDelegate?.sendFood(food: food!, edit: self.edit, tag: self.tag, fridgeTag: fridgeTag, changeFridgeTag: changeFridgeTag)
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func pressTypeButton(sender: UIButton) {
        
        if fridge?.fridgeType == .REFRE {
            
            var centerX = -46.25
            if sender == typeColdButton {
                centerX = -46.25
                food?.foodType = .REF
                typeColdButton.setTitleColor(.white, for: .normal)
                typeIceButton.setTitleColor(UIColor.refridgeColor(color: .gray), for: .normal)
            } else if sender == typeIceButton {
                centerX = 46.25
                food?.foodType = .FRE
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
    
    @objc func setExpDate(sender: UIDatePicker) {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let selectedDate: String = dateFormatter.string(from: sender.date)
        expirationDate.text = selectedDate
        
        food?.expireAt = sender.date
    }
    
    func changeFridge(to fridge: Fridge, at row: Int) {
        //fridges![fridgeTag].foods.remove(at: fridgeTag) //원래 냉장고에서 food 삭제
        
        fridges![row].foods.append(food!) // 바뀐 냉장고에 지금 바꾼 food를 넣고.
    }
    
    private func showToast(message : String) {
        let toastLabel = UILabel()
        //(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        toastLabel.textColor = UIColor.white
        toastLabel.font = UIFont.notoSansKR()
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.numberOfLines = 0
        toastLabel.layer.cornerRadius = 15
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        toastLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(50)
            
            make.height.equalTo(30)
        }
        UIView.animate(withDuration: 2.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.5
            
        },completion: { (isCompleted) in
            toastLabel.removeFromSuperview()
        }
        )
        
    }
    
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindConstraints()
    }
    
    func setup() {
        self.readFridgeList()
        
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
        
        
        if #available(iOS 14, *) {
            expirationDatePicker.sizeToFit()
            
        }
        expirationDate.inputView = expirationDatePicker
        
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
        contentView.addSubview(fridgeSelectField)
        
        nameField.text = food?.foodName
        memoField.text = food?.foodMemo
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        enrollDate.text = dateFormatter.string(from: food?.registeredDate ?? Date() as Date)
        
        fridgeSelectField.text = fridge?.fridgeName
        
        nameField.delegate = self
        memoField.delegate = self
        expirationDate.delegate = self
        fridgeSelectField.delegate = self
        
        fridgeSelectField.inputView = fridgePicker

        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapScrollView))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(singleTapGestureRecognizer)
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
        
        typeIceButton.isHidden = false
        if food?.foodType == .REF {
            sCenter = typeColdButton.snp.centerX
            typeColdButton.setTitleColor(.white, for: .normal)
            typeIceButton.setTitleColor(UIColor.refridgeColor(color: .gray), for: .normal)
        } else if food?.foodType == .FRE {
            sCenter = typeIceButton.snp.centerX
            typeColdButton.setTitleColor(UIColor.refridgeColor(color: .gray), for: .normal)
            typeIceButton.setTitleColor(.white, for: .normal)
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
        
        if fridge?.fridgeType == .ROOM {
            
            typeView.snp.remakeConstraints { make in
                make.centerY.equalTo(typeLabel)
                make.right.equalToSuperview().inset(20)
                make.width.equalTo(92)
                make.height.equalTo(38)
            }
            
            sCenter = typeColdButton.snp.centerX
            typeColdButton.setTitle("실온", for: .normal)
            typeColdButton.setTitleColor(.white, for: .normal)
            typeIceButton.isHidden = true
            food?.foodType = .ROOM
            
            typeSelectView.snp.remakeConstraints { make in
                make.centerY.equalToSuperview()
                make.centerX.equalTo(sCenter)
                make.width.equalTo(86)
                make.height.equalTo(33)
            }
            typeColdButton.snp.remakeConstraints { make in
                make.center.equalToSuperview()
            }
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
        fridgeSelectField.snp.makeConstraints { make in
            make.centerY.equalTo(fridgeLabel)
            make.right.bottom.equalToSuperview().inset(20)
        }
    }
}

// MARK: - Text Field Delegate

extension FoodEditViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let name = nameField.text {
            self.food?.foodName = name
        }
        if self.food?.foodName != "" {
            doneButton.setTitleColor(UIColor.refridgeColor(color: .blue), for: .normal)
        }
        
        self.food?.foodMemo = memoField.text ?? ""
        
        self.view.endEditing(true)
    }
    
    @objc func tapScrollView(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        if textField == self.nameField {
            if let text = textField.text {
                if text != "", text != " " {
                    doneButton.setTitleColor(UIColor.refridgeColor(color: .blue), for: .normal)
                }
                self.food?.foodName = text
            }
        } else if textField == self.memoField {
            if let text = textField.text {
                self.food?.foodMemo = text
            }
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.nameField,  textField.text!.count >= 0 {
            doneButton.setTitleColor(UIColor.refridgeColor(color: .blue), for: .normal)
        }
        
        return !(textField.text!.count > 20) //20자 제한.
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        var keyboardHeight = keyboardFrame.height
        
        let defaultTabBarHeight = TabBarController().tabBar.frame.size.height
        
        if #available(iOS 11.0, *) {
            let window = UIWindow.key
            let bottomInset = window?.safeAreaInsets.bottom ?? 0
            keyboardHeight -= bottomInset
        }
        
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight - defaultTabBarHeight, right: 0)
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

extension FoodEditViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fridges?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fridges![row].fridgeName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        fridgeSelectField.text = fridges![row].fridgeName
        changeFridgeTag = row
    }
    
    func readFridgeList() {
        let jsonDecoder = JSONDecoder()
        let file = "fridge.json"
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            
            do {
                let fridgeData = try Data(contentsOf: fileURL)
                self.fridges = try jsonDecoder.decode([Fridge].self, from: fridgeData)
            }
            catch { print("something went wrong in fridge.json")}
        }
    }
    
}

extension FoodEditViewController: UIScrollViewDelegate {
    //가로 방향 스크롤막기
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x > 0 {
            scrollView.contentOffset.x = 0
        }
    }
}
