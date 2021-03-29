//
//  FridgeSearchViewController.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/03/10.
//

import UIKit

class SearchViewController: UIViewController {
    
    var wholeFoods: [Food]?
    
    var fridge: Fridge? {
        didSet {
            self.foods = fridge?.foods
        }
    }
    var foods: [Food]?
    
    var isWholeSearch: Bool = false
    
    var cell = FoodTableViewCell()
    
    
    init(wholeFoods: [Food]) { //whole search
        self.wholeFoods = wholeFoods
        isWholeSearch = true
        super.init(nibName: nil, bundle: nil)
    }
    
    init(fridge: Fridge) {
        self.fridge = fridge
        isWholeSearch = false
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        field.addTarget(self, action: #selector(realTimeInput), for: .editingChanged)
        return field
    } ()
    
    private let searchButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "search"), for: .normal)
        btn.addTarget(self, action: #selector(search), for: .touchUpInside)
        return btn
    }()
    
    @objc func search() {
        if isWholeSearch {
            foods = wholeFoods?.filter { food in
                food.foodName.contains(searchField.text!)
            }
        } else {
            foods = fridge?.foods.filter { food in
                food.foodName.contains(searchField.text!)
            }
        }
        tableView.reloadData()
    }
    
    @objc func realTimeInput(sender: UITextField) {
        search()
    }
    
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
        
        searchField.delegate = self
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: "FoodTableViewCell", for: indexPath) as! FoodTableViewCell
        
        cell.food = foods?[indexPath.row]
        cell.selectionStyle = .none

        return cell
    }

}

// MARK: - Text Field Delegate

extension SearchViewController: UITextFieldDelegate {
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
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        var keyboardHeight = keyboardFrame.height

        let defaultTabBarHeight = TabBarController().tabBar.frame.size.height
        
        if #available(iOS 11.0, *) {
            let bottomInset = view.safeAreaInsets.bottom
            keyboardHeight -= bottomInset
        }

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
    }
}



