//
//  FridgeSearchViewController.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/03/10.
//

import UIKit

class FridgeSearchViewController: UIViewController {
    
    var foods: [Food] = [
        Food(name: "당근", type: "실온", registeredDate: Date(), expirationDate: Date(timeIntervalSince1970: 413454325), memo: "한묶음"),
        Food(name: "당근", type: "실온", registeredDate: Date(), expirationDate: Date(), memo: "한묶음"),
        Food(name: "아나", type: "냉장", registeredDate: Date(), expirationDate: Date(timeIntervalSince1970: 32948102934), memo: "한묶음")
    ]
    
    var cell = FoodTableViewCell()
    
    private let backButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "back"), for: .normal)
        btn.addTarget(self, action: #selector(back), for: .touchUpInside)
        return btn
    } ()
    
    private let searchView: UIView  = {
        let view = UIView()
        view.backgroundColor = UIColor.refridgeColor(color: .backgray)
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let searchField: UITextField = {
        let field = UITextField()
        field.placeholder = "모든 냉장고 내 식품을 검색할 수 있어요!"
        field.font = UIFont.notoSansKR(size: 15, family: .Regular)
        
        return field
    } ()
    
    private let searchButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "search"), for: .normal)
        return btn
    }()
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(FoodTableViewCell.self, forCellReuseIdentifier: "FoodTableViewCell")
        
        view.separatorInset = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 17)
        view.tableFooterView = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        bindConstraints()
    }
    
    func setup() {
        self.view.backgroundColor = .white
        self.view.addSubview(backButton)
        self.view.addSubview(searchView)
        searchView.addSubview(searchField)
        searchView.addSubview(searchButton)
        
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
    }
    
    func bindConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(5)
            make.left.equalToSuperview().inset(20)
        }
        searchView.snp.makeConstraints { make in
            make.centerY.equalTo(backButton.snp.centerY)
            make.left.equalTo(backButton.snp.right).offset(15)
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(32.5)
        }
        searchField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().inset(16)
            make.right.equalTo(searchButton.snp.left).offset(-10)
        }
        searchButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().inset(15)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

// MARK: -Table View

extension FridgeSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: "FoodTableViewCell", for: indexPath) as! FoodTableViewCell
        
        cell.food = foods[indexPath.row]

        return cell
    }
}

// MARK: - Text Field Delegate

extension FridgeSearchViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return !(textField.text!.count > 20) //20자 제한.
    }
    
    /*
    @objc func keyboardWillShow(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        var keyboardHeight = keyboardFrame.height

        let defaultTabBarHeight = TabBarController().tabBar.frame.size.height
        
        if #available(iOS 11.0, *) {
            let bottomInset = view.safeAreaInsets.bottom
            keyboardHeight -= bottomInset
        }
        //노치 있는 아이폰에선 safearea height 만큼 더 빼야되는데... 처리를 어떻게 하지?
        //탭바를 붙여놓은 경우엔 bottom 값이 0이 나옴 이런....
        
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight - defaultTabBarHeight , right: 0)
            self.tableView.scrollIndicatorInsets = self.tableView.contentInset
        })
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
            self.tableView.scrollIndicatorInsets = self.tableView.contentInset
        })
    } */
}



