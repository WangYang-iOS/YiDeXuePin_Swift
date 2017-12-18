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
}

class YYShopcartBottomView: UIView {

    @IBOutlet weak var priceLabel : UILabel!
    
    weak var delegate : YYShopcartBottomViewDelegate?
    
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
}
