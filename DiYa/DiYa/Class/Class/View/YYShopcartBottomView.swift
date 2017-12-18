//
//  YYShopcartBottomView.swift
//  DiYa
//
//  Created by wangyang on 2017/12/18.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit
@objc protocol YYShopcartBottomViewDelegate {
    @objc optional
    func didAllSelectedGoods(isSelected:Bool)
    func didCommitOrder()
    func didClickDeleteGoods()
    func didClickFavorateGoods()
}

class YYShopcartBottomView: UIView {

    @IBOutlet weak var priceLabel : UILabel!
    @IBOutlet weak var deleteButton : UIButton!
    @IBOutlet weak var favorateButton : UIButton!
    @IBOutlet weak var commitButton : UIButton!
    @IBOutlet weak var selectedButton : UIButton!
    
    weak var delegate : YYShopcartBottomViewDelegate?
    
    var isEditing : Bool? {
        didSet {
            guard let isEditing = isEditing else {
                return
            }
            if isEditing {
                deleteButton.isHidden = false
                favorateButton.isHidden = false
                priceLabel.isHidden = true
                commitButton.isHidden = true
            }else {
                deleteButton.isHidden = true
                favorateButton.isHidden = true
                priceLabel.isHidden = false
                commitButton.isHidden = false
            }
        }
    }
    
    var allSelected : Bool? {
        didSet {
            guard let allSelected = allSelected else {
                return
            }
            selectedButton.isSelected = allSelected
        }
    }
    
    
    var price:String? {
        didSet {
            guard let price = price else {
                return
            }
            let string = "合计：¥\(price)（不含运费）"
            let attributedStr = NSMutableAttributedString(string: string)
            attributedStr.addAttributes([NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12),
                                         NSAttributedStringKey.foregroundColor:UIColor.hexString(colorString: "333333")], range: NSRange(location: 0, length: 3))
            attributedStr.addAttributes([NSAttributedStringKey.font:UIFont.systemFont(ofSize: 14)], range: NSRange(location: 3, length: string.count - 3 - 6))
            attributedStr.addAttributes([NSAttributedStringKey.font:UIFont.systemFont(ofSize: 10)], range: NSRange(location: string.count - 6, length: 6))
            priceLabel.attributedText = attributedStr
        }
    }
    
    
    @IBAction func clickSelectedButton(_ sender : UIButton) {
        sender.isSelected = !sender.isSelected
        delegate?.didAllSelectedGoods?(isSelected: sender.isSelected)
    }
    
    @IBAction func commitOrder(_ sender : UIButton) {
        delegate?.didCommitOrder()
    }
    
    @IBAction func favoriteGoods(_ sender : UIButton) {
        delegate?.didClickFavorateGoods()
    }
    @IBAction func deleteButton(_ sender : UIButton) {
        delegate?.didClickDeleteGoods()
    }
    
    
}
