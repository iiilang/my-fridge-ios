//
//  ViewController.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/02/11.
//

import UIKit
import SnapKit

class FridgeViewController: UIViewController {
    
    // MARK: - variables in FridgeVC
    
    var fridges: [Fridge] = [Fridge]()
    
    var cell = FridgeTableViewCell()
    
    // MARK: - UI Components in FridgeVC
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "마이 냉장고"
        lbl.font = UIFont.notoSansKR(size: 22, family: .Bold)
        lbl.textColor = UIColor.refridgeColor(color: .titleBlack)
        return lbl
    }()
    
    private let searchButton: UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage(named: "search"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.addTarget(self, action: #selector(searchFood), for: .touchUpInside)
        return btn
    }()
    
    private let setButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "setting"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.addTarget(self, action: #selector(pressSettingButton), for: .touchUpInside)
        return btn
    }()
    
    private let plusButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "plus"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.addTarget(self, action: #selector(addFridge), for: .touchUpInside)
        return btn
    }()
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(FridgeTableViewCell.self, forCellReuseIdentifier: "FridgeTableViewCell")
        view.backgroundColor = .white
        view.separatorStyle = .none
        view.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 10))
        return view
    }()
    
    // MARK: - addTarget function in FridgeVC
    
    @objc func searchFood() {
        var foods = [Food]()
        for index in 0..<fridges.count {
            foods += fridges[index].foods
        }
        let VC = SearchViewController(wholeFoods: foods)
        navigationController?.pushViewController(VC, animated: true)
    }

    @objc func pressSettingButton() {
        let VC = SettingViewController()
        navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc func addFridge() {
        let fridge = Fridge(fridgeName: "", fridgeIcon: "broccoli", fridgeType: .REFREGERATOR, fridgeMemo: "")
        
        let VC = FridgeEditViewController(fridge: fridge, edit: false)
        VC.fridgeDelegate = self
        navigationController?.pushViewController(VC, animated: true)
    }
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setup()
        bindConstraints()
    }

    func setup() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(searchButton)
        self.view.addSubview(setButton)
        
        readFridgeList()
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        self.view.addSubview(plusButton)
    }

    func bindConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(10)
            make.left.equalTo(self.view).inset(20)
        }
        searchButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.right.equalTo(setButton.snp.left).offset(-10)
        }
        setButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.right.equalTo(self.view).inset(15)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(22)
            make.left.right.bottom.equalToSuperview()
        }
        plusButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaInsets.bottom).inset(15.5)
            make.right.equalTo(self.view).inset(20)
        }
    }
}

// MARK: - Receive Fridge Data to save in local

extension FridgeViewController: SendFridgeDelegate {
    
    func sendFridge(data: Fridge, edit: Bool, tag: Int) {
        if edit {
            self.fridges[tag] = data
            self.tableView.reloadData()
            self.saveToJsonFile()
        } else {
            if self.fridges.count < 10 {
                self.fridges.append(data)
                self.tableView.reloadData()
                self.saveToJsonFile()
            } else {
                showToast(message: "냉장고는 10개까지 등록할 수 있습니다.")
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
            make.bottom.equalToSuperview().inset(100)
            make.height.equalTo(30)
        }
        UIView.animate(withDuration: 2.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.5
            
        },completion: { (isCompleted) in
            toastLabel.removeFromSuperview()
        }
        )
        
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
    
    func saveToJsonFile() {
        let file = "fridge.json"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent(file)
            do {
                let jsonEncoder = JSONEncoder()
                jsonEncoder.outputFormatting = .prettyPrinted
                let jsonData = try! jsonEncoder.encode(fridges)
                
                try jsonData.write(to: fileURL)
            }
            catch { print("can not save in fridge.json") }
        }
    }
}

// MARK: - TableView

extension FridgeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fridges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: "FridgeTableViewCell", for: indexPath) as! FridgeTableViewCell
        
        cell.selectionStyle = .none
        cell.cellDelegate = self
        cell.moreButton.tag = indexPath.row
        cell.fridge = fridges[indexPath.row]
        
        cell.contentView.isUserInteractionEnabled = false //셀 안의 버튼을 누를 수 없을때.
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC = FoodViewController()
        VC.foodfridgeDelegate = self
        VC.fridgeTag = indexPath.row
        VC.fridge = fridges[indexPath.row]
        navigationController?.pushViewController(VC, animated: true)
    }
}

// MARK: - CellDelegate for button in table view cell

extension FridgeViewController: FridgeTableViewCellDelegate {
    func pressMoreButton(_ tag: Int) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let defaultAction = UIAlertAction(title: "편집", style: .default) { alert in
            let VC = FridgeEditViewController(fridge: self.fridges[tag], edit: true, fridgeTag: tag)
            VC.fridgeDelegate = self
            self.navigationController?.pushViewController(VC, animated: true)
            self.saveToJsonFile()
        }
        let deleteAction = UIAlertAction(title: "삭제", style: .default) { alert in
            let indexPath = IndexPath.init(row: tag, section: 0)
            self.fridges.remove(at: indexPath.row)
            self.tableView.reloadData()
            self.saveToJsonFile()
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(defaultAction)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
        //iOS 버그 constraints 오류 안뜨게.
        alert.view.subviews.flatMap({$0.constraints}).filter{ (one: NSLayoutConstraint)-> (Bool)  in
          return (one.constant < 0) && (one.secondItem == nil) &&  (one.firstAttribute == .width)
        }.first?.isActive = false
    }
}

//extension FridgeViewController: SendFoodDelegate {
//    func sendFood(data: Food, edit: Bool, tag: Int) {
//        if edit {
//            self.foods?[tag] = data
//            
//            //self.fridge?.foods = self.foods ?? [Food]()
//            self.tableView.reloadData()
//            self.fridges?[fridgeTag].foods = self.foods!
//            
//            self.saveToJsonFile()
//        } else {
//            self.foods?.append(data)
//            
//            self.fridges?[fridgeTag].foods = self.foods!
//            self.tableView.reloadData()
//            self.saveToJsonFile()
//        }
//        self.fridge = self.fridges?[fridgeTag]
//    }
//}
//

extension FridgeViewController: sendFoodToFridgeDelegate {
    func sendChangedFoodtoFridge(food: Food, fridge: Fridge, fridgeTag: Int, changeFridgeTag: Int) {
        
        var foodCopy: Food = food
        
        fridges[fridgeTag] = fridge
        
        if fridges[fridgeTag].fridgeType != fridges[changeFridgeTag].fridgeType {
            if fridges[changeFridgeTag].fridgeType == .REFREGERATOR {
                foodCopy.foodType = .REFRIGERATED
            } else {
                foodCopy.foodType = .ROOM
            }
        }
        
        fridges[changeFridgeTag].foods.append(foodCopy)
        self.saveToJsonFile()
    }
    
    func sendFoodtoFridge(fridge: Fridge, fridgeTag: Int) {
        fridges[fridgeTag] = fridge
        self.saveToJsonFile()
    }
}
