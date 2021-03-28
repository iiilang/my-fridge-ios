//
//  SettingViewController.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/03/19.
//

import UIKit

class SettingViewController: UIViewController {
    
    let settingCategorys: [String] = ["푸시 알림", "알림 주기", "알림 유형", "알림 시각"]
    let pushAlarms: [String] = ["알림 허용"]
    let alarmCycles: [String] = ["3일 전 알림", "당일 알림"]
    let alarmTypes: [String] = ["식품별로 따로 알림", "식품 모아서 한 번에 알림"]
    let alarmTimes: [String] = ["알림 시각"]
    
    var allowNoti: Bool = true
    var dayNoti: [Bool] = [true, true]
    var allNoti: Bool = true
    var time: Date = Date()
    
    private let backButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "back"), for: .normal)
        btn.addTarget(self, action: #selector(back), for: .touchUpInside)
        return btn
    } ()
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.notoSansKR(size: 18, family: .Medium)
        lbl.text = "알림 설정"
        lbl.textColor = UIColor.refridgeColor(color: .black)
        return lbl
    }()
    
    private let tableView: UITableView = {
        let view = UITableView(frame: CGRect(), style: .grouped)
        view.register(ToggleTableViewCell.self, forCellReuseIdentifier: "ToggleTableViewCell")
        view.register(RadioTableViewCell.self, forCellReuseIdentifier: "RadioTableViewCell")
        view.register(DatePickerTableViewCell.self, forCellReuseIdentifier: "DatePickerTableViewCell")
        
        view.tableFooterView = UIView()
        view.backgroundColor = .white
        view.allowsSelection = false
        view.separatorStyle = .none
        view.tag = 0

        return view
    }()
    
    
    
    private let line = UIImageView(image: UIImage(named: "line"))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        bindConstraints()
    }
    
    func setup() {
        self.view.addSubview(backButton)
        self.view.addSubview(titleLabel)
        self.view.addSubview(line)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.addSubview(tableView)
        
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
        line.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8.5)
            make.left.right.equalTo(self.view)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingCategorys.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 3 {
            return nil
        }
        return settingCategorys[section]
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let headerView = UIView()
        
        if section != 3 {
            let myLabel = UILabel()
            myLabel.font = UIFont.notoSansKR(size: 16, family: .Medium)
            myLabel.textColor = UIColor.refridgeColor(color: .black)
            myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
            
            headerView.addSubview(myLabel)
            myLabel.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview().inset(8)
                make.left.equalToSuperview().inset(20)
            }
        }
            
        return headerView
    }
        
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        if section != 3 {
            let view = UIView()
            view.backgroundColor = UIColor.refridgeColor(color: .lightgray)
            
            footerView.addSubview(view)
            view.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(8)
                make.left.right.equalToSuperview().inset(17.5)
                make.height.equalTo(0.8)
            }
        }
        return footerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return pushAlarms.count
        } else if section == 1 {
            return alarmCycles.count
        } else if section == 2 {
            return alarmTypes.count
        } else if section == 3 {
            return alarmTimes.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ToggleTableViewCell", for: indexPath) as! ToggleTableViewCell
            cell.title = pushAlarms[indexPath.row]
            cell.toggle.isOn = allowNoti
            
            cell.contentView.isUserInteractionEnabled = false
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ToggleTableViewCell", for: indexPath) as! ToggleTableViewCell
            cell.title = alarmCycles[indexPath.row]
            cell.toggle.isOn = dayNoti[indexPath.row]
            
            cell.contentView.isUserInteractionEnabled = false
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RadioTableViewCell", for: indexPath) as! RadioTableViewCell
            
            let item = alarmTypes[indexPath.row]
            cell.title = item
            
            if indexPath.row == 0 {
                cell.radioButton.isSelected = allNoti
            } else if indexPath.row == 1 {
                cell.radioButton.isSelected = !allNoti
            }
            
            
            //cell.cellDelegate = self
            
            cell.contentView.isUserInteractionEnabled = false
            return cell
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DatePickerTableViewCell", for: indexPath) as! DatePickerTableViewCell
            cell.title = alarmTimes[indexPath.row]
            
            cell.contentView.isUserInteractionEnabled = false 
            return cell
        }
        
        return UITableViewCell()
    }
}

// MARK: - Text Field Delegate

extension SettingViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardHeight = keyboardFrame.height
        
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight , right: 0)
            self.tableView.scrollIndicatorInsets = self.tableView.contentInset
        })
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
            self.tableView.scrollIndicatorInsets = self.tableView.contentInset
        })
    }

}

//extension SettingViewController: ToggleTableViewCellDelegate {
//    func switchAllowToggle(sender: UISwitch) {
//        self.allowNoti = sender.isOn
//        if !sender.isOn { //꺼져있으면
//            dayNoti = [false, false]
//            allNoti = false
//        }
//    }
//}

