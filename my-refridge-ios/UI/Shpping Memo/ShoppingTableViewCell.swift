//
//  ShoppingTableViewCell.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/02/12.
//

import UIKit
import SnapKit

protocol ShoppingTableViewCellDelegate {
    func pressCheckButton(_ tag: Int)
    func changeMemo(at tag: Int, to memo: String)
    func deleteRow(at tag: Int)
}

class ShoppingTableViewCell: BaseTableViewCell {

    var cellDelegate: ShoppingTableViewCellDelegate?
    
    var first: Bool = true
    
    var shoppingMemo: ShoppingMemo? {
        didSet {
            checkBox.isSelected = shoppingMemo?.isSelected ?? false
            
            var string = shoppingMemo?.memo ?? ""
            
            if checkBox.isSelected {
                
                if !first {
                    string = memoField.text ?? "⚠warning"
                }
                
                memoField.isUserInteractionEnabled = false
                
                memoField.text = nil
                memoField.attributedText = string.strikeThrough()
                memoField.textColor = UIColor.refridgeColor(color: .lightgray)
 
            } else {
                memoField.isUserInteractionEnabled = true
                
                memoField.attributedText = nil
                memoField.text = string
                memoField.textColor = UIColor.refridgeColor(color: .gray)
            }
        }
        
    }
    
    
    let checkBox: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "checkBox"), for: .normal)
        btn.setImage(UIImage(named: "checkBoxSelected"), for: .selected)
        return btn
    } ()
    
    
    let memoField: UITextField = {
        let fld = UITextField()
        fld.font = UIFont.notoSansKR(size: 15, family: .Regular)
        
        return fld
    }()
    
    
    private let moveButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "move"), for: .normal)
        
        return btn
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setup() {
        self.addSubview(checkBox)
        self.addSubview(memoField)
        self.addSubview(moveButton)
        
        
        checkBox.addTarget(self, action: #selector(pressCheckButton), for: .touchUpInside)
        memoField.addTarget(self, action: #selector(changeMemo), for: .editingDidEnd)
    }
    
    override func bindConstraints() {
        checkBox.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(17.5)
            make.left.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(17.5).priority(999)
        }
        memoField.snp.makeConstraints { make in
            make.centerY.equalTo(checkBox.snp.centerY)
            make.left.equalToSuperview().offset(45.5)
            make.right.equalToSuperview().inset(40)
        }
        
        moveButton.snp.makeConstraints { make in
            make.centerY.equalTo(checkBox.snp.centerY)
            make.right.equalToSuperview().inset(20)
        }
    }

    
    
    //checkBox를 누르면 체크가 되도록 button에 대한 isSelected를 바꾸고,
    //delegate method로 가서 해당 버튼에 대한 isSelected 를 바꿔서 array에 저장.
    //이거 배열에 저장을 어케하지...?
    @objc func pressCheckButton(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        shoppingMemo?.isSelected = sender.isSelected
        cellDelegate?.pressCheckButton(sender.tag)
    }
    
    @objc func changeMemo(_ textField: UITextField) {
        if textField.text != "" {
            let string = textField.text ?? ""
            shoppingMemo?.memo = string
            cellDelegate?.changeMemo(at: textField.tag, to: string)
        } else {
            cellDelegate?.deleteRow(at: textField.tag)
        }
    }
}


