//
//  YYGoodsInfoView.swift
//  DiYa
//
//  Created by wangyang on 2017/12/13.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

class YYGoodsInfoView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var marketPriceLabel: UILabel!
    @IBOutlet weak var salesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    var goodsModel : GoodsModel? {
        didSet {
            guard let goodsModel = goodsModel else {
                return
            }
            titleLabel.text = goodsModel.title
            priceLabel.text = "¥" + goodsModel.price
            marketPriceLabel.text = "¥" + goodsModel.marketPrice
            salesLabel.text = "已售出" + goodsModel.sales + "件"
        }
    }
    
    var evaluate : String? {
        didSet {
            guard let evaluate = evaluate else {
                return
            }
            commentsLabel.text = evaluate + "条评价"
        }
    }
    
}
