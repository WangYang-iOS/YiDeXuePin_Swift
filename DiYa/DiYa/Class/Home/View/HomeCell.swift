//
//  HomeCell.swift
//  DiYa
//
//  Created by wangyang on 2017/11/10.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var scrollView: YYScrollView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var clickMoreGoods : (()->())?
    
    
    var goodsList : [GoodsModel]? {
        didSet {
            scrollView.frame = CGRect(x: 0, y: 42, width: bounds.width, height: bounds.height - 42 - 10)
            scrollView.goodsList = goodsList
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        scrollView.moreBlock = { [weak self] in
            if self?.clickMoreGoods != nil {
                self?.clickMoreGoods!()
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
