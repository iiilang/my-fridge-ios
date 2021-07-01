//
//  RadioTableViewCell.swift
//  my-refridge-ios
//
//  Created by 임은지 on 2021/03/19.
//

import UIKit

protocol RadioTableViewCellDelegate {
    func tapRadioButton(sender: UIButton)
}
class RadioTableViewCell: BaseTableViewCell {

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var cellDelegate: RadioTableViewCellDelegate?

    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.notoSansKR(size: 15, family: .Regular)
        lbl.textColor = UIColor.refridgeColor(color: .gray)
        return lbl
    }()
    
    let radioButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "radioOff"), for: .normal)
        btn.setImage(UIImage(named: "radioOn"), for: .selected)
        return btn
    }()
    
    override func setup() {
        self.addSubview(titleLabel)
        self.addSubview(radioButton)
        
        radioButton.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)
    }
    
    override func bindConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(20)
        }
        radioButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.right.equalToSuperview().inset(20)
        }
    }

    @objc func radioButtonTapped(_ radioButton: UIButton) {
        let isSelected = !self.radioButton.isSelected
        self.radioButton.isSelected = isSelected
        if isSelected {
            deselectOtherButton()
        }
        
        //let tableView = self.superview as! UITableView
        //let tappedCellIndexPath = tableView.indexPath(for: self)!
        cellDelegate?.tapRadioButton(sender: radioButton)
    }
    
    func deselectOtherButton() {
        let tableView = self.superview as! UITableView
        let tappedCellIndexPath = tableView.indexPath(for: self)!
        let indexPaths = tableView.indexPathsForVisibleRows
        for indexPath in indexPaths! {
            if indexPath.row != tappedCellIndexPath.row && indexPath.section == tappedCellIndexPath.section {
                let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row, section: indexPath.section)) as! RadioTableViewCell
                cell.radioButton.isSelected = false
            }
        }
    }

}
