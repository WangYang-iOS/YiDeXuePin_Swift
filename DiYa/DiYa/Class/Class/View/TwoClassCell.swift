//
//  TwoClassCell.swift
//  DiYa
//
//  Created by wangyang on 2017/11/10.
//  Copyright © 2017年 wangyang. All rights reserved.
//

import UIKit
import SDWebImage

class TwoClassCell: UICollectionViewCell {

    @IBOutlet weak var goodsImageView: UIImageView!
    @IBOutlet weak var goodsLabel: UILabel!
    
    var goodsModel:GoodsModel? {
        didSet {
            goodsLabel.text = goodsModel?.name
            goodsImageView.sd_setImage(with: URL(string: goodsModel?.picture ?? ""), placeholderImage: UIImage(named: "ic_home_logo"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
