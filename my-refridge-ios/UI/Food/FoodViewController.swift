//
//  FoodViewController.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/03/23.
//

import UIKit

class FoodViewController: UIViewController {
    
    var fridge: Fridge? {
        didSet {
            titleLabel.text = fridge?.name
            
            if fridge?.type == "냉장/냉동" {
                typeLabel.text = "냉장"
                typeView.backgroundColor = UIColor.refridgeColor(color: .orange)
                iceView.isHidden = false
                foodTypeView.isHidden = false
            } else {
                typeLabel.text = "실온"
                typeView.backgroundColor = UIColor.refridgeColor(color: .purple)
                iceView.isHidden = true
                foodTypeView.isHidden = true
            }
            
            foods = fridge?.foods
        }
    }

    var foods: [Food]?
    
    var cell = FoodTableViewCell()
    
    private let backButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "back"), for: .normal)
        btn.addTarget(self, action: #selector(back), for: .touchUpInside)
        return btn
    } ()
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.notoSansKR(size: 18, family: .Medium)
        lbl.textColor = UIColor.refridgeColor(color: .black)
        return lbl
    }()
    
    private let typeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.refridgeColor(color: .orange)
        view.layer.cornerRadius = 10
        return view
    }()

    private let typeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "냉장"
        lbl.font = UIFont.notoSansKR(size: 12, family: .Medium)
        lbl.textColor = .white
        return lbl
    } ()
    
    private let iceView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.refridgeColor(color: .green)
        view.layer.cornerRadius = 10
        return view
    }()

    private let iceLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "냉동"
        lbl.font = UIFont.notoSansKR(size: 12, family: .Medium)
        lbl.textColor = .white
        return lbl
    } ()
    
    private let searchButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "search"), for: .normal)
        btn.addTarget(self, action: #selector(pressSearchButton), for: .touchUpInside)
        return btn
    }()
    
    private let foodTypeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 247/255, green: 248/255, blue: 249/255, alpha: 1)
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let foodTypeSelectView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.refridgeColor(color: .blue)
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let typeAllButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("모두", for: .normal)
        btn.titleLabel?.font = UIFont.notoSansKR(size: 15, family: .Medium)
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(pressTypeButton), for: .touchUpInside)
        return btn
    }()
    
    private let typeColdButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("냉장", for: .normal)
        btn.titleLabel?.font = UIFont.notoSansKR(size: 15, family: .Medium)
        btn.setTitleColor(UIColor.refridgeColor(color: .gray), for: .normal)
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(pressTypeButton), for: .touchUpInside)
        return btn
    }()
    
    private let headerView = UIView()
    
    private let countLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.notoSansKR(size: 12, family: .Regular)
        lbl.textColor = UIColor.refridgeColor(color: .lightgray)
        return lbl
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
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(FoodTableViewCell.self, forCellReuseIdentifier: "FoodTableViewCell")
        
        view.separatorInset = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 17)
        view.tableFooterView = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    private let plusButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "plus"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.addTarget(self, action: #selector(pressPlusButton), for: .touchUpInside)
        return btn
    }()
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }

    @objc func pressSearchButton() {
        let VC = FridgeSearchViewController()
        navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc func pressTypeButton(sender: UIButton) {
        var centerX = -67
        if sender == typeAllButton {
            centerX = -67
            typeAllButton.setTitleColor(.white, for: .normal)
            typeColdButton.setTitleColor(UIColor.refridgeColor(color: .gray), for: .normal)
            typeIceButton.setTitleColor(UIColor.refridgeColor(color: .gray), for: .normal)
        } else if sender == typeColdButton {
            centerX = 0
            typeAllButton.setTitleColor(UIColor.refridgeColor(color: .gray), for: .normal)
            typeColdButton.setTitleColor(.white, for: .normal)
            typeIceButton.setTitleColor(UIColor.refridgeColor(color: .gray), for: .normal)
        } else if sender == typeIceButton {
            centerX = 67
            
            typeAllButton.setTitleColor(UIColor.refridgeColor(color: .gray), for: .normal)
            typeColdButton.setTitleColor(UIColor.refridgeColor(color: .gray), for: .normal)
            typeIceButton.setTitleColor(.white, for: .normal)
        }

        foodTypeSelectView.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(centerX)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
    }
    
    @objc func pressPlusButton() {
        let VC = FoodEditViewController()
        navigationController?.pushViewController(VC, animated: true)
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
        self.view.addSubview(typeView)
        typeView.addSubview(typeLabel)
        self.view.addSubview(iceView)
        iceView.addSubview(iceLabel)
        self.view.addSubview(searchButton)
        
        self.view.addSubview(foodTypeView)
        foodTypeView.addSubview(foodTypeSelectView)
        foodTypeView.addSubview(typeAllButton)
        foodTypeView.addSubview(typeColdButton)
        foodTypeView.addSubview(typeIceButton)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        //tableView.tableHeaderView = headerView
        self.view.addSubview(tableView)
        self.view.addSubview(plusButton)
    }
    
    func bindConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(5)
            make.left.equalToSuperview().inset(20)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.left.equalTo(backButton.snp.right).offset(11)
        }
        typeView.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.left.equalTo(titleLabel.snp.right).offset(5)
            make.height.equalTo(19)
            make.width.equalTo(41.5)
        }
        typeLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        iceView.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.left.equalTo(typeView.snp.right).offset(5)
            make.height.equalTo(19)
            make.width.equalTo(41.5)
        }
        iceLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        searchButton.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.right.equalToSuperview().inset(20)
        }
        
        foodTypeView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(22.5)
            make.centerX.equalToSuperview()
            make.width.equalTo(225)
            make.height.equalTo(40)
        }
        foodTypeSelectView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(-67)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        typeAllButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(-67)
        }
        typeColdButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        typeIceButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(67)
        }
        tableView.snp.makeConstraints { make in
            if foodTypeView.isHidden {
                make.top.equalTo(titleLabel.snp.bottom).offset(15)
            } else {
                make.top.equalTo(foodTypeView.snp.bottom).offset(20)
            }
            make.left.right.bottom.equalToSuperview()
        }
        plusButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaInsets.bottom).inset(15.5)
            make.right.equalTo(self.view).inset(20)
        }
    }
}

// MARK: -Table View

extension FoodViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: "FoodTableViewCell", for: indexPath) as! FoodTableViewCell
        cell.selectionStyle = .none
        
        cell.food = foods?[indexPath.row]

        return cell
    }
}
