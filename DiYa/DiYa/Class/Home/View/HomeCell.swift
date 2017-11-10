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
    
    var goodsList : [GoodsModel]? {
        didSet {
            scrollView.goodsList = goodsList
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
