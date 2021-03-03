//
//  ShoppingViewController.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/02/11.
//

import UIKit



class ShoppingViewController:
    UIViewController {
    
    var shoppingList: Array<ShoppingMemo> = [ShoppingMemo]()
        //[ShoppingMemo(memo: "aaaaa", isSelected: false), ShoppingMemo(memo: "당근", isSelected: false), ShoppingMemo(memo: "키위", isSelected: false), ShoppingMemo(memo: "지금은 소녀시대", isSelected: false), ShoppingMemo(memo: "아 또 뭐 사야하냐", isSelected: false), ShoppingMemo(memo: "러ㅓㅓㅓ러ㅓㅓㅓasdfkewjfa;", isSelected: false), ShoppingMemo(memo: "ㅓasdf", isSelected: false), ShoppingMemo(memo: "testtesttest", isSelected: false), ShoppingMemo(memo: "귀찮.", isSelected: false), ShoppingMemo(memo: "ㅇ", isSelected: false), ShoppingMemo(memo: "테이블뷰 삽질~", isSelected: false), ShoppingMemo(memo: "테이블뷰 삽질2~", isSelected: false)]
        
    var cell = ShoppingTableViewCell()
    
    var first: Bool = true
    
    private let copyButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "copy"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.addTarget(self, action: #selector(pressCopyButton), for: .touchUpInside)
        return btn
    }()
    
    private let label: UILabel = {
        let lbl = UILabel()
        lbl.text = "장보기 메모"
        lbl.font = UIFont.notoSansKR(size: 18, family: .Medium)
        return lbl
    }()
    
    
    private let deleteButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "delete"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.addTarget(self, action: #selector(pressDeleteButton), for: .touchUpInside)
        return btn
    } ()
    
    private let line = UIImageView(image: UIImage(named: "lineShop"))
    
    private let dateLabel: UILabel = {
        let lbl = UILabel()
        let now = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        lbl.text = dateFormatter.string(from: now as Date)
        lbl.font = UIFont.notoSansKR(size: 18, family: .Medium)
        return lbl
    }()
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(ShoppingTableViewCell.self, forCellReuseIdentifier: "ShoppingTableViewCell")
        
        tableView.isUserInteractionEnabled = true
        tableView.allowsSelection = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 17)
        
        return tableView
    }()
    
    private let writeButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("+ 항목 추가", for: .normal)
        btn.titleLabel?.font = UIFont.notoSansKR(size: 16, family: .Medium)
        btn.setTitleColor(UIColor.refridgeColor(color: .black), for: .normal)
        btn.addTarget(self, action: #selector(pressWriteButton), for: .touchUpInside)
        return btn
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        tableviewSetUp()
        keyboardSetUp()
        bindConstraints()
        //self.tableView.reloadData()
    }
    
    func setup() {
        self.view.addSubview(copyButton)
        self.view.addSubview(label)
        self.view.addSubview(deleteButton)
        self.view.addSubview(line)
        self.view.addSubview(dateLabel)
        self.view.backgroundColor = .white
        
        readShoppingList()
    }
    
    func readShoppingList() {
        
        let jsonDecoder = JSONDecoder()
        
        let file = "shopping.json"
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            
            do {
                let shoppingData = try Data(contentsOf: fileURL)
                self.shoppingList = try jsonDecoder.decode([ShoppingMemo].self, from: shoppingData)
                first = false
            }
            catch { print("something went wrong")}
        }
        
    }
    
    func tableviewSetUp() {
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 45))
        footerView.addSubview(writeButton)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        
        
        tableView.tableFooterView = footerView
       
        self.view.addSubview(tableView)
        self.view.addInteraction(UIDropInteraction(delegate: self))
        
        setEditing(true, animated: true)
    }
    
    func keyboardSetUp() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func bindConstraints() {
        copyButton.snp.makeConstraints { make in
            make.centerY.equalTo(label)
            make.left.equalTo(self.view).inset(15)
        }
        label.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.right.equalTo(self.view).inset(144)
        }
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(label)
            make.right.equalTo(self.view).inset(16)
        }
        line.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(8.5)
            make.left.right.equalTo(self.view)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(12)
            make.left.equalTo(self.view).inset(20)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        writeButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func pressCopyButton() {
        let pasteBoard = UIPasteboard.general
        var string = ""
        
        for index in 0..<shoppingList.count {
            string += "\(shoppingList[index].memo)\n"
        }
        pasteBoard.string = string
    }
    
    @objc func pressDeleteButton() {
        let alert = UIAlertController(title: "전체 삭제하시겠습니까?", message: nil, preferredStyle: UIAlertController.Style.alert)
        let defaultAction = UIAlertAction(title: "취소", style: .default)
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { action in
            self.shoppingList.removeAll()
            self.tableView.reloadData()
        }
        alert.addAction(defaultAction)
        alert.addAction(deleteAction)

        present(alert, animated: true, completion: nil)
    }

    
    @objc func pressWriteButton() {
        self.shoppingList.append(ShoppingMemo(memo: "", isSelected: false))
        
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath.init(row: self.shoppingList.count-1, section: 0)], with: .automatic)
        tableView.endUpdates()
        cell.memoField.becomeFirstResponder()
        
        saveToJsonFile()
    }
}

extension ShoppingViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate, UITableViewDropDelegate, UIDropInteractionDelegate
{
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath) as! ShoppingTableViewCell
        
        cell.cellDelegate = self
        
        cell.checkBox.tag = indexPath.row
        
        cell.memoField.delegate = self
        cell.memoField.tag = indexPath.row
        
        cell.contentView.isUserInteractionEnabled = false //셀 안의 버튼을 누를 수 없을때.
        
        cell.shoppingMemo = shoppingList[indexPath.row]
        cell.first = self.first
        
        
        //hamburger button
        cell.editingAccessoryType = .none
        let view = UIImageView(image: UIImage(named: "move"))
        cell.editingAccessoryView = view

        return cell
    }
    
    //밀어서 삭제 가능하게
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .normal, title: nil) { (action, view, completion) in
            self.shoppingList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completion(true)
        }
    
        
        action.backgroundColor = UIColor.refridgeColor(color: .redDelete)
        action.image = UIImage(named: "swipeToDelete")
        
        
        let configuration = UISwipeActionsConfiguration(actions: [action])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
        
    }


    //순서 변경 가능.
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    /*
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }*/
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedCell = self.shoppingList[sourceIndexPath.row]
        shoppingList.remove(at: sourceIndexPath.row)
        shoppingList.insert(movedCell, at: destinationIndexPath.row)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        //super.setEditing(editing, animated: animated)
        //tableView.setEditing(editing, animated: animated)
    }
    
    //drag n drop
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return []
    }

}



extension ShoppingViewController: UITextFieldDelegate {
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
        let tabBarHeight = TabBarController().tabBar.frame.size.height
        //print(tabBarHeight)
        
        if #available(iOS 11.0, *) {
            let bottomInset = view.safeAreaInsets.bottom
            keyboardHeight -= bottomInset
            
        }
        //노치 있는 아이폰에선 safearea height 만큼 더 빼야되는데... 처리를 어떻게 하지?
        //탭바를 붙여놓은 경우엔 bottom 값이 0이 나옴 이런....
        
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight - tabBarHeight, right: 0)
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

extension ShoppingViewController: ShoppingTableViewCellDelegate {
    
    func saveToJsonFile() {
        let file = "shopping.json"
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent(file)
            
            do {
                let jsonEncoder = JSONEncoder()
                jsonEncoder.outputFormatting = .prettyPrinted
                let jsonData = try! jsonEncoder.encode(shoppingList)
                
                try jsonData.write(to: fileURL)
            }
            catch { print("not save") }
        }
    }
    
    func pressCheckButton(_ tag: Int) {
        shoppingList[tag].isSelected = !shoppingList[tag].isSelected
        saveToJsonFile()
    }
    func changeMemo(at tag: Int,to string: String) {
        shoppingList[tag].memo = string
        print(shoppingList[tag])
        
        saveToJsonFile()
    }
    func deleteRow(at tag: Int) {
        let indexPath = IndexPath.init(row: tag, section: 0)
        shoppingList.remove(at: indexPath.row)
        tableView.reloadData() //textfield tag랑 array index 안맞는 문제 해결!!
    }
}


