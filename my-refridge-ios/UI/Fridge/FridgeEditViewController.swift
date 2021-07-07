//
//  FridgeEditViewController.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/03/16.
//

import UIKit
import Alamofire

protocol SendFridgeDelegate {
    func sendFridge(fridge: Fridge, edit: Bool)
}

class FridgeEditViewController: UIViewController {
    
    // MARK: - variables in FridgeEditVC
    
    var fridge: Fridge?
    var edit: Bool = false
    var fridgeTag: Int = -1
    var fridgeDelegate: SendFridgeDelegate?
    
    var firstType: FridgeType
    
    // MARK: - Initializaition
    
    init(fridge: Fridge, edit: Bool) {
        self.fridge = fridge
        self.firstType = fridge.fridgeType
        titleLabel.text = edit ? "냉장고 편집" : "냉장고 추가"
        self.edit = edit
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
        lbl.textColor = UIColor.refridgeColor(color: .titleBlack)
        return lbl
    }()
    
    private let doneButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("완료", for: .normal)
        btn.contentMode = .scaleAspectFill
        btn.setTitleColor(UIColor(hex: "#9EA4AAFF"), for: .normal)
        btn.titleLabel?.font = UIFont.notoSansKR(size: 16, family: .Medium)
        btn.addTarget(self, action: #selector(done), for: .touchUpInside)
        return btn
    } ()
    
    private let line = UIImageView(image: UIImage(named: "line"))
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let iconView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 55
        view.layer.borderWidth = 0.8
        view.layer.borderColor = CGColor(red: 201/255, green: 205/255, blue: 210/255, alpha: 1)
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
        view.layer.borderColor = CGColor(red: 201/255, green: 205/255, blue: 210/255, alpha: 1)
        view.clipsToBounds = true
        return view
    }()
    
    private let broccoliButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "broccoli"), for: .normal)
        btn.addTarget(self, action: #selector(setIcon), for: .touchUpInside)
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
        btn.addTarget(self, action: #selector(setIcon), for: .touchUpInside)
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
        btn.addTarget(self, action: #selector(setIcon), for: .touchUpInside)
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
        btn.addTarget(self, action: #selector(setIcon), for: .touchUpInside)
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
        field.textColor = UIColor.refridgeColor(color: .gray)
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
        view.backgroundColor = UIColor.refridgeColor(color: .backgray)
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
        btn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
        return btn
    }()
    
    private let typeRoomButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("실온", for: .normal)
        btn.titleLabel?.font = UIFont.notoSansKR(size: 15, family: .Medium)
        btn.setTitleColor(UIColor.refridgeColor(color: .gray), for: .normal)
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(pressTypeButton), for: .touchUpInside)
        btn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
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
        field.textColor = UIColor.refridgeColor(color: .gray)
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
    
    // MARK: - addTarget function
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func done() {
        if let name = nameField.text {
            self.fridge?.fridgeName = name
        }
        
        self.fridge?.fridgeMemo = memoField.text ?? ""
        
        
        if fridge?.fridgeName == "" {
            nameField.resignFirstResponder()
            memoField.resignFirstResponder()
            showToast(message: "이름을 넣어주세요.")
        } else {
            let foodType = (fridge?.fridgeType == .REFREGERATOR) ? FoodType.REFRIGERATED : FoodType.ROOM
            if edit {
                if firstType != fridge?.fridgeType { //냉장고 type 바뀜.
                    for index in 0..<fridge!.foods.count {
                        fridge!.foods[index].foodType = foodType //foods 전체 타입 바뀌도록.
                    }
                }
                editFridge()
            } else {
                
                saveFridge()
            }
            fridgeDelegate?.sendFridge(fridge: fridge!, edit: self.edit)
            navigationController?.popViewController(animated: true)
        }
    }
    
    func editFridge() {
        let urlString = url + "/api/v1/fridges/\(String(describing: fridge?.fridgeId))"
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        

        let param: Parameters = [
            "fridgeName": self.fridge!.fridgeName,
            "fridgeIcon": self.fridge!.fridgeIcon,
            "fridgeType": self.fridge!.fridgeType,
            "fridgeBasic": self.fridge!.fridgeBasic,
            "fridgeMemo": self.fridge!.fridgeMemo
        ]
        

        AF.request(
            urlString,
            method: .put,
            parameters: param,
            encoding: JSONEncoding.default,
            headers: header
        )
        .responseJSON { [self] response in
            switch response.result {
            case .success:
                guard let result = response.data else { return }
                print( String(decoding: result, as: UTF8.self) )
                
                if response.response?.statusCode == 200 {
                    
//                    do {
                        let decoder = JSONDecoder()
                        //print(result)
                    self.fridge = try! decoder.decode(Fridge.self, from: result)
//                    } catch {
//                        print("food parsing error")
//                    }
                    
                    
                    self.fridgeDelegate?.sendFridge(fridge: fridge!, edit: self.edit)
                    //print(self.food!.foodId)
                    navigationController?.popViewController(animated: true)
                } else {
                    showToast(message: "저장에 실패했습니다.")
                }
            case .failure(let error):
                print(error)
                showToast(message: "저장에 실패했습니다.")
                return
            }
        }
    }
    
    func saveFridge() {
        
        let urlString = url + "/api/v1/fridges"
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        
        let param: Parameters = [
            "fridgeName": self.fridge!.fridgeName,
            "fridgeIcon": self.fridge!.fridgeIcon,
            "fridgeBasic": self.fridge!.fridgeBasic,
            "fridgeType": self.fridge!.fridgeType,
            "fridgeMemo": self.fridge!.fridgeMemo,
            "userId": userId ?? ""
        ]
        

        AF.request(
            urlString,
            method: .post,
            parameters: param,
            encoding: JSONEncoding.default,
            headers: header
        )
        .responseJSON { [self] response in
            switch response.result {
            case .success:
                guard let result = response.data else { return }
                print( String(decoding: result, as: UTF8.self) )
                
                if response.response?.statusCode == 200 {
                    
//                    do {
                        let decoder = JSONDecoder()
                        //print(result)
                        fridge = try! decoder.decode(Fridge.self, from: result)
//                    } catch {
//                        print("food parsing error")
//                    }
                    
                    
                    self.fridgeDelegate?.sendFridge(fridge: fridge!, edit: self.edit)
                    //print(self.food!.foodId)
                    navigationController?.popViewController(animated: true)
                } else {
                    showToast(message: "저장에 실패했습니다.")
                }
            case .failure(let error):
                print(error)
                showToast(message: "저장에 실패했습니다.")
                return
            }
        }
    }
    
    private func showToast(message : String) {
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        toastLabel.textColor = UIColor.white
        toastLabel.font = UIFont.notoSansKR()
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
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

    
    @objc func setIcon(sender: UIButton) {
        selectView.snp.remakeConstraints { make in
            make.width.height.equalTo(60)
            make.center.equalTo(sender)
        }
        
        if sender == broccoliButton {
            icon.image = UIImage(named: "broccoliBig")
            fridge?.fridgeIcon = "broccoli"
        } else if sender == oilButton {
            icon.image = UIImage(named: "oilBig")
            fridge?.fridgeIcon = "oil"
        } else if sender == lettuceButton {
            icon.image = UIImage(named: "lettuceBig")
            fridge?.fridgeIcon = "lettuce"
        } else if sender == snackButton {
            icon.image = UIImage(named: "snackBig")
            fridge?.fridgeIcon = "snack"
        }
    }
    
    @objc func pressTypeButton(sender: UIButton) {
        var centerX = -46.25
        if sender == typeIceButton {
            centerX = -46.25
            fridge?.fridgeType = .REFREGERATOR
            typeIceButton.setTitleColor(.white, for: .normal)
            typeRoomButton.setTitleColor(UIColor.refridgeColor(color: .gray), for: .normal)
        } else if sender == typeRoomButton {
            centerX = 46.25
            fridge?.fridgeType = .ROOM
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
        fridge?.fridgeBasic = sender.isOn
    }
    
    // MARK: - viewDidLoad
    
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
        nameField.text = fridge?.fridgeName
        memoField.text = fridge?.fridgeMemo
    }
    
    func keyboardSetUp() {
        nameField.delegate = self
        memoField.delegate = self
        scrollView.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //scroll view tap gesture for keyboard hide
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
        
        if fridge?.fridgeIcon == "broccoli" {
            icon.image = UIImage(named: "broccoliBig")
            someView = broccoliView
        } else if fridge?.fridgeIcon == "oil" {
            icon.image = UIImage(named: "oilBig")
            someView = oilView
        } else if fridge?.fridgeIcon == "lettuce" {
            icon.image = UIImage(named: "lettuceBig")
            someView = lettuceView
        } else if fridge?.fridgeIcon == "snack" {
            icon.image = UIImage(named: "snackBig")
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
        if fridge?.fridgeType == .REFREGERATOR {
            sCenter = typeIceButton.snp.centerX
            typeIceButton.setTitleColor(.white, for: .normal)
            typeRoomButton.setTitleColor(UIColor.refridgeColor(color: .gray), for: .normal)
        } else if fridge?.fridgeType == .ROOM {
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
}

// MARK: - Text Field Delegate

extension FridgeEditViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let name = nameField.text {
            self.fridge?.fridgeName = name
        }
        if self.fridge?.fridgeName != "" {
            doneButton.setTitleColor(UIColor.refridgeColor(color: .blue), for: .normal)
        }
        
        self.fridge?.fridgeMemo = memoField.text ?? ""
        
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
                self.fridge?.fridgeName = text
            }
        } else if textField == self.memoField {
            if let text = textField.text {
                self.fridge?.fridgeMemo = text
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
            self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight - defaultTabBarHeight , right: 0)
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

// MARK: - UIScrollViewDelegate

extension FridgeEditViewController: UIScrollViewDelegate {
    //가로 방향 스크롤막기
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x > 0 {
            scrollView.contentOffset.x = 0
        }
    }
}

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
