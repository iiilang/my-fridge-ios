//
//  FoodViewController.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/03/23.
//

import UIKit

protocol sendFoodToFridgeDelegate {
    func sendFoodtoFridge(fridge: Fridge, fridgeTag: Int)
    func sendChangedFoodtoFridge(food: Food, fridge: Fridge, fridgeTag: Int, changeFridgeTag: Int)
}

class FoodViewController: UIViewController {
    // MARK: - variables
    
    var fridgeTag: Int = -1
    
    var foodfridgeDelegate: sendFoodToFridgeDelegate?
    
    var fridge: Fridge? {
        didSet {
            titleLabel.text = fridge?.fridgeName
            
            
            if fridge?.fridgeType == .REFRE {
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

    var foods: [Food]? {
        didSet {
            countLabel.text = "전체 \(foods!.count)"
        }
    }
    
    var cell = FoodTableViewCell()
    
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
    
    private let typeIceButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("냉동", for: .normal)
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
        lbl.text = "전체"
        return lbl
    }()
    
    private let sortButton: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.notoSansKR(size: 12, family: .Regular)
        btn.setTitleColor(UIColor.refridgeColor(color: .lightgray), for: .normal)
        btn.setTitle("등록일순", for: .normal)
        btn.addTarget(self, action: #selector(changeSort), for: .touchUpInside)
        return btn
    } ()
    
    private let sortTriangle = UIImageView(image: UIImage(named: "triangle"))
    
    private let line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.refridgeColor(color: .lightgray)
        view.clipsToBounds = true
        view.layer.borderWidth = 0.5
        view.layer.borderColor = CGColor(red: 201/255, green: 205/255, blue: 210/255, alpha: 1)
        return view
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
    
    // MARK: - addTarget function
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }

    @objc func pressSearchButton() {
        let VC = SearchViewController(fridge: self.fridge!)
        navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc func pressTypeButton(sender: UIButton) {
        var centerX = -67
        if sender == typeAllButton {
            centerX = -67
            typeAllButton.setTitleColor(.white, for: .normal)
            typeColdButton.setTitleColor(UIColor.refridgeColor(color: .gray), for: .normal)
            typeIceButton.setTitleColor(UIColor.refridgeColor(color: .gray), for: .normal)
            foods = fridge?.foods
            tableView.reloadData()
        } else if sender == typeColdButton {
            centerX = 0
            typeAllButton.setTitleColor(UIColor.refridgeColor(color: .gray), for: .normal)
            typeColdButton.setTitleColor(.white, for: .normal)
            typeIceButton.setTitleColor(UIColor.refridgeColor(color: .gray), for: .normal)
            
            foods = fridge?.foods.filter { food in
                food.foodType == .REF
            }
            tableView.reloadData()
        } else if sender == typeIceButton {
            centerX = 67
            
            typeAllButton.setTitleColor(UIColor.refridgeColor(color: .gray), for: .normal)
            typeColdButton.setTitleColor(UIColor.refridgeColor(color: .gray), for: .normal)
            typeIceButton.setTitleColor(.white, for: .normal)
            
            foods = fridge?.foods.filter { food in
                food.foodType == .FRE
            }
            tableView.reloadData()
        }

        foodTypeSelectView.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(centerX)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
    }
    
    
    
    @objc func pressPlusButton() {
        var type: FoodType
        
        if self.fridge?.fridgeType == .REFRE {
            type = FoodType.REF
        } else {
            type = FoodType.ROOM
        }
        let food = Food(foodName: "", foodType: type, foodMemo: "", expireAt: Date(), registeredDate: Date())
        
        let VC = FoodEditViewController(fridgeTag: fridgeTag, fridge: self.fridge!, food: food, edit: false, tag: -1)
        //VC.fridge = self.fridge
        VC.foodDelegate = self
        navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc func changeSort() {
        if sortButton.titleLabel?.text == "유통기한순" {
            sortButton.setTitle("등록일순", for: .normal)
            self.foods?.sort {
                $0.registeredDate < $1.registeredDate
            }
            tableView.reloadData()
            
        } else if sortButton.titleLabel?.text == "등록일순" {
            sortButton.setTitle("유통기한순", for: .normal)
            self.foods?.sort {
                $0.expireAt < $1.expireAt
            }
            tableView.reloadData()
        }
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
        
        self.view.addSubview(headerView)
        headerView.addSubview(countLabel)
        headerView.addSubview(sortButton)
        headerView.addSubview(sortTriangle)
        //headerView.addSubview(editButton)
        headerView.addSubview(line)
        
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
        headerView.snp.makeConstraints { make in
            if foodTypeView.isHidden {
                make.top.equalTo(titleLabel.snp.bottom).offset(15)
            } else {
                make.top.equalTo(foodTypeView.snp.bottom).offset(20)
            }
            make.left.right.equalToSuperview()
        }
        countLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(7.5)
            make.left.equalToSuperview().inset(20)
        }
        sortButton.snp.makeConstraints { make in
            make.centerY.equalTo(countLabel)
            make.right.equalTo(sortTriangle.snp.left).offset(-5)
        }
        sortTriangle.snp.makeConstraints { make in
            make.centerY.equalTo(countLabel)
            make.right.equalToSuperview().offset(-20)
        }
        line.snp.makeConstraints { make in
            make.top.equalTo(countLabel.snp.bottom).offset(7.5)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
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
        cell.tag = indexPath.row

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC = FoodEditViewController(fridgeTag: fridgeTag, fridge: self.fridge!, food: (foods?[indexPath.row])!, edit: true, tag: indexPath.row)
        VC.foodDelegate = self
        navigationController?.pushViewController(VC, animated: true)
    }
    
    //밀어서 삭제 가능하게
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .normal, title: nil) { (action, view, completion) in
            self.foods?.remove(at: indexPath.row)
            self.fridge?.foods = self.foods ?? [Food]()
            self.foodfridgeDelegate?.sendFoodtoFridge(fridge: self.fridge!, fridgeTag: self.fridgeTag)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completion(true)
        }
    
        
        action.backgroundColor = UIColor.refridgeColor(color: .red)
        action.image = UIImage(named: "swipeToDelete")
        
        
        let configuration = UISwipeActionsConfiguration(actions: [action])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
        
    }
}

extension FoodViewController: SendFoodDelegate {
    func sendFood(food: Food, edit: Bool, tag: Int, fridgeTag: Int, changeFridgeTag: Int) {
        
        if fridgeTag == changeFridgeTag { //냉장고 안 바꿈
            if edit {
                self.foods?[tag] = food
                self.fridge?.foods = self.foods ?? [Food]()
                
                self.tableView.reloadData()
            } else {
                self.foods?.append(food)
                self.fridge?.foods = self.foods ?? [Food]()
                
                self.tableView.reloadData()
            }
            
            foodfridgeDelegate?.sendFoodtoFridge(fridge: self.fridge!, fridgeTag: self.fridgeTag)
            
        } else { //냉장고 바꿈
            if edit { // 수정중이었으면 원래 냉장고에서 삭제 후 새로운 냉장고에 저장.
                self.foods?.remove(at: tag)
                self.fridge?.foods = self.foods ?? [Food]()
                
                self.tableView.reloadData()
                
            }
            //수정 중이 아니었으면 그냥 바뀐 냉장고에 저장.
            foodfridgeDelegate?.sendChangedFoodtoFridge(food: food, fridge: fridge!, fridgeTag: fridgeTag, changeFridgeTag: changeFridgeTag)
        }
    }
}
