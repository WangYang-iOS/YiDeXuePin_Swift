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
            priceLabel.text = price
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
