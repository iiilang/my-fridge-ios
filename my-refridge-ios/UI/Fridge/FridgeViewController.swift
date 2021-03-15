//
//  ViewController.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/02/11.
//

import UIKit
import SnapKit

class FridgeViewController: UIViewController {
    
    var fridges: [Fridge] = [
        Fridge(icon: "broccoli", name: "냉장고1", type: "냉장/냉동", memo: "주방에 있는 냉장고", isBasic: true),
        Fridge(icon: "lettuce", name: "냉장고2", type: "실온", memo: "베란다에 있는 김치 냉장고", isBasic: false),
        Fridge(icon: "oil", name: "냉장", type: "실온", memo: "베란다", isBasic: false),
        Fridge(icon: "snack", name: "냉장고", type: "냉장/냉동", memo: "아놔.. 이제 뭐라고 써...", isBasic: false),
        Fridge(icon: "broccoli", name: "냉장고1", type: "냉장/냉동", memo: "주방에 있는 냉장고", isBasic: false),
        Fridge(icon: "lettuce", name: "냉장고2", type: "실온", memo: "베란다에 있는 김치 냉장고", isBasic: false),
        Fridge(icon: "oil", name: "냉장", type: "실온", memo: "베란다", isBasic: false),
        Fridge(icon: "snack", name: "냉장고", type: "냉장/냉동", memo: "아놔.. 이제 뭐라고 써...", isBasic: false)
    ]
    // = [Fridge]()
    
    var cell = FridgeTableViewCell()
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "마이 냉장고"
        lbl.font = UIFont.notoSansKR(size: 22, family: .Bold)
        return lbl
    }()
    
    private let searchButton: UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage(named: "search"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.addTarget(self, action: #selector(pressSearchButton), for: .touchUpInside)
        return btn
    }()
    
    private let setButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "setting"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.addTarget(self, action: #selector(pressSetButton), for: .touchUpInside)
        return btn
    }()
    
    private let plusButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "plus"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.addTarget(self, action: #selector(pressPlusButton), for: .touchUpInside)
        return btn
    }()

    
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(FridgeTableViewCell.self, forCellReuseIdentifier: "FridgeTableViewCell")
        view.isUserInteractionEnabled = true
        view.allowsSelection = false
        view.backgroundColor = .white
        view.separatorStyle = .none
        return view
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white

        setup()
        bindConstraints()
    }

    func setup() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(searchButton)
        self.view.addSubview(setButton)
        
        
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
    
    @objc func pressSearchButton() {
        let VC = FridgeSearchViewController()
        navigationController?.pushViewController(VC, animated: true)
        
    }

    @objc func pressSetButton() {
        print("setting")
    }
    
    @objc func pressPlusButton() {
        print("plus")
    }
}

extension FridgeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fridges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: "FridgeTableViewCell", for: indexPath) as! FridgeTableViewCell
        
        cell.cellDelegate = self
        cell.moreButton.tag = indexPath.row
        
        cell.contentView.isUserInteractionEnabled = false //셀 안의 버튼을 누를 수 없을때.
        
        cell.fridge = fridges[indexPath.row]

        //hamburger button
        cell.editingAccessoryType = .none
        let view = UIImageView(image: UIImage(named: "move"))
        cell.editingAccessoryView = view

        return cell
    }
    
    
}

extension FridgeViewController: FridgeTableViewCellDelegate {
    func pressMoreButton(_ tag: Int) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let defaultAction = UIAlertAction(title: "편집", style: .default) { alert in
            //self.saveToJsonFile()
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
            catch { print("not save") }
        }
    }
}
