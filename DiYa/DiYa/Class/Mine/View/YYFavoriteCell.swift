//
//  YYFavoriteCell.swift
//  DiYa
//
//  Created by wangyang on 2017/11/24.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit

class YYFavoriteCell: UICollectionViewCell {
    @IBOutlet weak var cellWidth: NSLayoutConstraint!
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var marketPriceLabel: UILabel!
    @IBOutlet weak var salesLabel: UILabel!
    
    var goodsModel : GoodsModel? {
        didSet {
            headerImageView.sd_setImage(with: URL(string: goodsModel?.picture ?? ""))
            titleLabel.text = goodsModel?.title
            priceLabel.text = "¥" + (goodsModel?.price)!
            marketPriceLabel.text = "¥" + (goodsModel?.marketPrice)!
            salesLabel.text = "已售出 " + (goodsModel?.sales)!
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellWidth.constant = (SCREEN_WIDTH - 10) / 2.0
    }

}
